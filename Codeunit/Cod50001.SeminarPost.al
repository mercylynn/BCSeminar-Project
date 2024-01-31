codeunit 50001 SeminarPost
{
    TableNo = SeminarRegistrationHeader;

    VAR
        SeminarRegHeader: Record SeminarRegistrationHeader;
        SeminarRegLine: Record SeminarRegistrationLine;
        PstdSeminarRegHeader: Record PostedSeminarRegHeader;
        PstdSeminarRegLine: Record PostedSeminarRegLine;
        SeminarCommentLine: Record SeminarCommentLine;
        SeminarCommentLine2: Record SeminarCommentLine;
        SeminarCharge: Record SeminarCharge;
        PstdSeminarCharge: Record PostedSeminarCharge;
        Room: Record "Seminar Room";
        Instructor: Record Instructor;
        Job: Record Job;
        Res: Record Resource;
        Customer: Record Customer;
        // ResLedgEntry: Record "Res. Ledger Entry";
        JobLedgEntry: Record "Job Ledger Entry";
        SeminarJnlLine: Record SeminarJournalLine;
        SourceCodeSetup: Record "Source Code Setup";
        JObJnlLine: Record "Job Journal Line";
        // JobJnlPostLine: Codeunit SeminarJnlPostLine;
        SeminarJnlPostLine: Codeunit SeminarJnlPostLine;
        // ResJnlPostLine: Codeunit "Res. Jnl.-Post Line";
        JobJnlPostLine: Codeunit "Job Jnl.-Post Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        Window: Dialog;
        SourceCode: Code[10];
        LineCount: Integer;
        NoParticipantErr: Label 'There is no participant to post.';
        PostingLineNoTxt: Label 'Posting lines              #2######\';
        Text003: Label 'Registration';
        Text004: Label 'Registration %1  -> Posted Reg. %2';
        Text005: Label 'The combination of dimensions used in %1 is blocked. %2';
        Text006: Label 'The combination of dimensions used in %1, line no. %2 is blocked. %3';
        Text007: Label 'The dimensions used in %1 are invalid. %2';
        Text008: Label 'The dimensions used in %1, line no. %2 are invalid. %3';

    trigger OnRun()
    begin
        CLEARALL;
        SeminarRegHeader := Rec;
        SeminarRegHeader.TESTFIELD("Posting Date");
        SeminarRegHeader.TESTFIELD("Document Date");
        SeminarRegHeader.TESTFIELD("Seminar No.");
        SeminarRegHeader.TESTFIELD(Duration);
        SeminarRegHeader.TESTFIELD("Instructor Code");
        SeminarRegHeader.TESTFIELD("Room Code");
        SeminarRegHeader.TESTFIELD(Status, SeminarRegHeader.Status::Closed);

        SeminarRegLine.RESET;
        SeminarRegLine.SETRANGE("Document No.", Rec."No.");
        IF SeminarRegLine.ISEMPTY THEN
            ERROR(NoParticipantErr);

        Window.OPEN(
          '#1#################################\\' +
           PostingLineNoTxt);
        Window.UPDATE(1, STRSUBSTNO('%1 %2', Text003, Rec."No."));

        IF SeminarRegHeader."Posting No." = '' THEN BEGIN
            Rec.TESTFIELD("Posting No. Series");
            Rec."Posting No." := NoSeriesMgt.GetNextNo(Rec."Posting No. Series", Rec."Posting Date", TRUE);
            Rec.MODIFY;
            COMMIT;
        END;
        SeminarRegLine.LOCKTABLE;

        SourceCodeSetup.GET;
        SourceCode := SourceCodeSetup.Seminar;

        PstdSeminarRegHeader.INIT;
        PstdSeminarRegHeader.TRANSFERFIELDS(SeminarRegHeader);
        PstdSeminarRegHeader."No." := Rec."Posting No.";
        PstdSeminarRegHeader."No. Series" := Rec."Posting No. Series";
        PstdSeminarRegHeader."Source Code" := SourceCode;
        PstdSeminarRegHeader."User ID" := USERID;
        PstdSeminarRegHeader.INSERT;

        Window.UPDATE(1, STRSUBSTNO(Text004, Rec."No.",
          PstdSeminarRegHeader."No."));

        CopyCommentLines(
          SeminarCommentLine."Document Type"::"Seminar Registration",
          SeminarCommentLine."Document Type"::"Posted Seminar Registration",
          Rec."No.", PstdSeminarRegHeader."No.");
        CopyCharges(Rec."No.", PstdSeminarRegHeader."No.");

        LineCount := 0;
        SeminarRegLine.RESET;
        SeminarRegLine.SETRANGE("Document No.", Rec."No.");
        IF SeminarRegLine.FINDSET THEN BEGIN
            REPEAT
                LineCount := LineCount + 1;
                Window.UPDATE(2, LineCount);

                SeminarRegLine.TESTFIELD("Bill-to Customer No.");
                SeminarRegLine.TESTFIELD("Participant Contact No.");

                IF NOT SeminarRegLine."To Invoice" THEN BEGIN
                    SeminarRegLine."Seminar Price" := 0;
                    SeminarRegLine."Line Discount %" := 0;
                    SeminarRegLine."Line Discount Amount" := 0;
                    SeminarRegLine.Amount := 0;
                END;

                // Post seminar entry
                PostSeminarJnlLine(SeminarJnlLine."Charge Type"::Participant); // Participant

                // Insert posted seminar registration line
                PstdSeminarRegLine.INIT;
                PstdSeminarRegLine.TRANSFERFIELDS(SeminarRegLine);
                PstdSeminarRegLine."Document No." := PstdSeminarRegHeader."No.";
                PstdSeminarRegLine.INSERT;
            UNTIL SeminarRegLine.NEXT = 0;
        END;

        // Post charges to seminar ledger
        PostCharges;

        // Post instructor to seminar ledger
        PostSeminarJnlLine(SeminarJnlLine."Charge Type"::Instructor); // Instructor

        // Post seminar room to seminar ledger
        PostSeminarJnlLine(SeminarJnlLine."Charge Type"::Room); // Room

        Rec.DELETE;
        SeminarRegLine.DELETEALL;

        SeminarCommentLine.SETRANGE("Document Type",
          SeminarCommentLine."Document Type"::"Seminar Registration");
        SeminarCommentLine.SETRANGE("No.", Rec."No.");
        SeminarCommentLine.DELETEALL;

        SeminarCharge.SETRANGE(Description);
        SeminarCharge.DELETEALL;
        Rec := SeminarRegHeader;
    end;

    LOCAL PROCEDURE CopyCommentLines(
        FromDocumentType: Enum SeminarCommentLineDocumentType;
        ToDocumentType: Enum SeminarCommentLineDocumentType;
        FromNumber: Code[20]; ToNumber: Code[20])
    BEGIN
        SeminarCommentLine.RESET;
        SeminarCommentLine.SETRANGE("Document Type", FromDocumentType);
        SeminarCommentLine.SETRANGE("No.", FromNumber);
        IF SeminarCommentLine.FINDSET(FALSE, FALSE) THEN BEGIN
            REPEAT
                SeminarCommentLine2 := SeminarCommentLine;
                SeminarCommentLine2."Document Type" := ToDocumentType;
                SeminarCommentLine2."No." := ToNumber;
                SeminarCommentLine2.INSERT;
            UNTIL SeminarCommentLine.NEXT = 0;
        END;
    END;

    LOCAL PROCEDURE CopyCharges(FromNumber: Code[20]; ToNumber: Code[20])
    BEGIN
        SeminarCharge.RESET;
        SeminarCharge.SETRANGE("Document No.", FromNumber);
        IF SeminarCharge.FINDSET(FALSE, FALSE) THEN BEGIN
            REPEAT
                PstdSeminarCharge.TRANSFERFIELDS(SeminarCharge);
                PstdSeminarCharge."Document No." := ToNumber;
                PstdSeminarCharge.INSERT;
            UNTIL SeminarCharge.NEXT = 0;
        END;
    END;

    LOCAL PROCEDURE PostJobJnlLine(Job: Record Job): Integer
    BEGIN
        // Job.TESTFIELD("Quantity Per Day");
        JobJnlLine.INIT;
        JobJnlLine."Entry Type" := JobJnlLine."Entry Type"::Usage;
        JobJnlLine."Document No." := PstdSeminarRegHeader."No.";
        // JobJnlLine."Seminar No." := Job."No.";
        JobJnlLine."Posting Date" := SeminarRegHeader."Posting Date";
        JobJnlLine."Reason Code" := SeminarRegHeader."Reason Code";
        JobJnlLine.Description := SeminarRegHeader."Seminar Name";
        JobJnlLine."Gen. Prod. Posting Group" := SeminarRegHeader."Gen. Prod. Posting Group";
        JobJnlLine."Posting No. Series" := SeminarRegHeader."Posting No. Series";
        JobJnlLine."Source Code" := SourceCode;
        // JobJnlLine."Resource No." := Job."No.";
        // JobJnlLine."Unit of Measure Code" := Resource."Base Unit of Measure";
        // JobJnlLine."Unit Cost" := Resource."Unit Cost";
        JobJnlLine."Qty. per Unit of Measure" := 1;
        // JobJnlLine.Quantity := SeminarRegHeader.Duration * Resource."Quantity Per Day";
        JobJnlLine."Total Cost" := JobJnlLine."Unit Cost" * JobJnlLine.Quantity;
        JobJnlLine."Seminar Registration No." := SeminarRegHeader."Seminar No.";
        JobJnlLine."Seminar Registration No." := PstdSeminarRegHeader."No.";
        JobJnlPostLine.RunWithCheck(JobJnlLine);

        JobLedgEntry.FINDLAST;
        EXIT(JobLedgEntry."Entry No.");
    END;

    LOCAL PROCEDURE PostSeminarJnlLine(ChargeType: Enum SeminarJournalChargeType)
    BEGIN
        SeminarJnlLine.INIT;
        SeminarJnlLine."Seminar No." := SeminarRegHeader."Seminar No.";
        SeminarJnlLine."Posting Date" := SeminarRegHeader."Posting Date";
        SeminarJnlLine."Document Date" := SeminarRegHeader."Document Date";
        SeminarJnlLine."Document No." := PstdSeminarRegHeader."No.";
        SeminarJnlLine."Charge Type" := ChargeType;
        SeminarJnlLine."Instructor Code" := SeminarRegHeader."Instructor Code";
        SeminarJnlLine."Starting Date" := SeminarRegHeader."Starting Date";
        SeminarJnlLine."Seminar Registration No." := PstdSeminarRegHeader."No.";
        SeminarJnlLine."Room Code." := SeminarRegHeader."Room Code";
        SeminarJnlLine."Source Type" := SeminarJnlLine."Source Type"::Seminar;
        SeminarJnlLine."Source No." := SeminarRegHeader."Seminar No.";
        SeminarJnlLine."Source Code" := SourceCode;
        SeminarJnlLine."Reason Code" := SeminarRegHeader."Reason Code";
        SeminarJnlLine."Posting No. Series" := SeminarRegHeader."Posting No. Series";
        CASE ChargeType OF
            ChargeType::Instructor:
                BEGIN
                    Instructor.GET(SeminarRegHeader."Instructor code");
                    SeminarJnlLine.Description := Instructor.Name;
                    SeminarJnlLine.Type := SeminarJnlLine.Type::Resource;
                    SeminarJnlLine.Chargeable := FALSE;
                    SeminarJnlLine.Quantity := SeminarRegHeader.Duration;
                    // SeminarJnlLine."Res. Ledger Entry No." := PostJobJnlLine(Instructor);
                END;
            ChargeType::Room:
                BEGIN
                    Room.GET(SeminarRegHeader."Room Code");
                    SeminarJnlLine.Description := Room.Name;
                    SeminarJnlLine.Type := SeminarJnlLine.Type::Resource;
                    SeminarJnlLine.Chargeable := FALSE;
                    SeminarJnlLine.Quantity := SeminarRegHeader.Duration;
                    // Post to resource ledger
                    // SeminarJnlLine."Res. Ledger Entry No." := PostJobJnlLine(Room);
                END;
            ChargeType::Participant:
                BEGIN
                    SeminarJnlLine."Bill-to Customer No." := SeminarRegLine."Bill-to Customer No.";
                    SeminarJnlLine."Participant Contact No." := SeminarRegLine."Participant Contact No.";
                    SeminarJnlLine."Participant Name" := SeminarRegLine."Participant Name";
                    SeminarJnlLine.Description := SeminarRegLine."Participant Name";
                    SeminarJnlLine.Type := SeminarJnlLine.Type::Resource;
                    SeminarJnlLine.Chargeable := SeminarRegLine."To Invoice";
                    SeminarJnlLine.Quantity := 1;
                    SeminarJnlLine."Unit Price" := SeminarRegLine.Amount;
                    SeminarJnlLine."Total Price" := SeminarRegLine.Amount;
                END;
            ChargeType::Charge:
                BEGIN
                    SeminarJnlLine.Description := SeminarCharge.Description;
                    SeminarJnlLine."Bill-to Customer No." := SeminarCharge."Bill-to Customer No.";
                    SeminarJnlLine.Type := SeminarCharge.Type;
                    SeminarJnlLine.Quantity := SeminarCharge.Quantity;
                    SeminarJnlLine."Unit Price" := SeminarCharge."Unit Price";
                    SeminarJnlLine."Total Price" := SeminarCharge."Total Price";
                    SeminarJnlLine.Chargeable := SeminarCharge."To Invoice";
                END;
        END;

        SeminarJnlPostLine.RunWithCheck(SeminarJnlLine);
    END;

    LOCAL PROCEDURE PostCharges()
    BEGIN
        SeminarCharge.RESET;
        SeminarCharge.SETRANGE("Document No.", SeminarRegHeader."No.");
        IF SeminarCharge.FINDSET(FALSE, FALSE) THEN BEGIN
            REPEAT
                PostSeminarJnlLine(SeminarJnlLine."Charge Type"::Charge); // Charge
            UNTIL SeminarCharge.NEXT = 0;
        END;
    END;
}

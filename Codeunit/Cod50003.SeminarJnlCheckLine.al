codeunit 50003 SeminarJnlCheckLine
{
    TableNo = SeminarJournalLine;

    trigger OnRun()
    begin
        RunCheck(Rec);
    end;

    var
        ErrDateCannotBeClosingDate: Label 'cannot be a closing date';

    procedure RunCheck(var SemJnlLine: Record SeminarJournalLine)
    begin
        If SemJnlLine.EmptyLine() then
            exit;

        SemJnlLine.TestField("Posting Date");
        SemJnlLine.TestField("Instructor Code");
        SemJnlLine.TestField("Seminar No.");

        CASE SemJnlLine."Charge Type" OF
            SemJnlLine."Charge Type"::Instructor:
                SemJnlLine.TestField("Instructor Code");
            SemJnlLine."Charge Type"::Room:
                SemJnlLine.TestField("Room Code.");
            SemJnlLine."Charge Type"::Participant:
                SemJnlLine.TestField("Participant Contact No.");
        END;

        IF SemJnlLine.Chargeable THEN
            SemJnlLine.TestField("Bill-to Customer No.");

        CheckDates(SemJnlLine);
    end;

    local procedure CheckDates(SemJnlLine: Record SeminarJournalLine)
    var
        UserSetupManagement: Codeunit "User Setup Management";
    begin
        SemJnlLine.TestField("Posting Date");
        if SemJnlLine."Posting Date" <> NormalDate(SemJnlLine."Posting Date") then
            SemJnlLine.FieldError("Posting Date", ErrDateCannotBeClosingDate);

        UserSetupManagement.CheckAllowedPostingDate(SemJnlLine."Posting Date");

        if SemJnlLine."Document Date" = 0D then
            exit;

        if SemJnlLine."Document Date" <> NormalDate(SemJnlLine."Document Date") then
            SemJnlLine.FieldError("Document Date", ErrDateCannotBeClosingDate);
    end;
}
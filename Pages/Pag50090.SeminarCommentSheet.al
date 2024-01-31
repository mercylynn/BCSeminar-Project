page 50090 SeminarCommentSheet
{
    Caption = 'Seminar Comment Sheet';
    PageType = List;
    SourceTable = SeminarCommentLine;
    UsageCategory = None;
    MultipleNewLines = true;
    LinksAllowed = false;
    DelayedInsert = true;
    DataCaptionFields = "No.";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetUpNewLine();
    end;
}

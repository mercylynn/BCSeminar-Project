pageextension 50001 SourceCodeSetupExt extends "Source Code Setup"
{
    layout
    {
        addlast(content)
        {
            group("Seminar Management")
            {
                Caption = 'Seminar Management';
                field(Seminar; Rec.Seminar)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}



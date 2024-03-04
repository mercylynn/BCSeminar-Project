page 50012 "Posted Reg List"
{
    ApplicationArea = All;
    Caption = 'Posted Reg List';
    PageType = List;
    SourceTable = SeminarRegistrationHeader;
    SourceTableView = where(Status = filter(Approved), Posted = filter(true));
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;



    layout
    {
        area(content)
        {
            repeater(General)
            {
            }
        }
    }
}

table 50007 Department
{
    Caption = 'Department';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
}

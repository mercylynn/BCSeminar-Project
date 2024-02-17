table 50006 "Ticket "
{
    Caption = 'Ticket ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            TableRelation = "No. Series";
        }
        field(2; Tittle; Text[20])
        {
            Caption = 'Tittle';
        }
        field(3; Description; Text[20])
        {
            Caption = 'Description';
        }
        field(4; Ticket_Priority; Option)
        {
            Caption = 'Priority';
            OptionMembers = Low,Medium,High,Urgent;
        }
        field(5; Department; Code[20])
        {
            Caption = 'Department';
            TableRelation = Department;

        }
        field(6; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Resource Where(Type = const(Person));
        }

        field(7; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,InProgress,Resolved,Closed;
        }
        field(8; "Assigned To"; Code[20])
        {
            Caption = 'Assigned To';
            // TableRelation =
        }
        field(9; "Employee Name"; Text[20])
        {
            Caption = 'Employee Name';
        }
        field(10; "Employee email"; Text[100])
        {
            Caption = 'Employee Name';
        }
        field(11; "Category"; Text[100])
        {
            Caption = 'Ticket Category';
            TableRelation = "Ticket Category";
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

table 50020 Instructor
{
    Caption = 'Instructor';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(3; "Internal/External"; Option)
        {
            Caption = 'Internal/External';
            OptionMembers = Internal,External;
        }
        field(4; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource Where(Type = const(Person));
            trigger OnValidate()
            begin
                if Resource.Get("Resource No.") and (Name = '')
                 Then
                    Name := Resource.Name;
            end;
        }
        field(5; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = Contact;
            trigger OnValidate()
            begin
                if Contact.Get("Resource No.") and (Name = '')
                 Then
                    Name := Contact.Name;
            end;

        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    var
        Contact: Record Contact;
        Resource: Record Resource;
}

/// <summary>
/// Report SeminarRegistrationCertificate (ID 50005).
/// </summary>
report 50005 SeminarRegistrationCertificate
{
    ApplicationArea = All;
    Caption = 'SeminarRegistrationCertificate';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Certificate.rdlc';

    dataset
    {
        dataitem(SeminarRegistrationHeader; SeminarRegistrationHeader)
        {
            column(No; "No.")
            {
            }
            column(SeminarNo; "Seminar No.")
            {
            }
            column(SeminarName; "Seminar Name")
            {
            }
            column(StartingDate; "Starting Date")
            {
            }
            column(Picture; CompanyInfo.Picture)
            {

            }
            column(CompanyName; CompanyInfo.Name)
            {

            }
            column(Instructor_Name; "Instructor Name")
            {

            }

            dataitem(PostedSeminarRegLine; PostedSeminarRegLine)
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.") order(ascending);

                column(Bill_to_Customer_No_; "Bill-to Customer No.")
                {

                }
                column(Participant_Contact_No_; "Participant Contact No.")
                {

                }
                column(Participant_Name; "Participant Name")
                {

                }

                trigger OnAfterGetRecord()
                begin
                    CompanyInfo.Get;
                    CompanyInfo.CalcFields(Picture);
                end;
            }

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        CompanyInfo: Record "Company Information";
}

pageextension 50004 ExtendNavigationArea extends "Accountant Role Center"
{
    actions
    {
        addlast(Sections)
        {
            group("Seminars")
            {
                action(Seminar)
                {
                    RunObject = page "Seminar List";
                    ApplicationArea = All;
                }
                action("Seminar List")
                {
                    RunObject = page "Seminar List";
                    ApplicationArea = All;
                }
                action("Seminar Registration")
                {
                    RunObject = page SeminarRegistration;
                    ApplicationArea = All;
                }
                action("Seminar Setup")
                {
                    RunObject = page "Seminar Setup";
                    ApplicationArea = All;
                }
                action("Rooms")
                {
                    RunObject = Page "Resource List";
                    RunPageView = WHERE(Type = CONST(MACHINE));
                    ApplicationArea = All;
                }
                action("Instructors")
                {
                    RunObject = Page "Resource List";
                    RunPageView = WHERE(Type = CONST(Person));
                    ApplicationArea = All;
                }

                // Creates a sub-menu
                group("Seminar Posted Document")
                {
                    action("Posted Registration List")
                    {
                        ApplicationArea = All;
                        RunObject = page PostedSeminarRegList;
                    }
                    action("Posted Invoice")
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }
    }
}
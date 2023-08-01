// Program.cs

using System;

namespace LegalSupportPlatform
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Welcome to the Legal Support Platform!");
            Console.WriteLine("Please choose an option:");
            Console.WriteLine("1. Create a new case");
            Console.WriteLine("2. View existing cases");
            Console.WriteLine("3. Exit");

            while (true)
            {
                string option = Console.ReadLine();
                switch (option)
                {
                    case "1":
                        CreateNewCase();
                        break;
                    case "2":
                        ViewExistingCases();
                        break;
                    case "3":
                        Console.WriteLine("Goodbye!");
                        return;
                    default:
                        Console.WriteLine("Invalid option. Please try again.");
                        break;
                }

                Console.WriteLine("Please choose an option:");
                Console.WriteLine("1. Create a new case");
                Console.WriteLine("2. View existing cases");
                Console.WriteLine("3. Exit");
            }
        }

        static void CreateNewCase()
        {
            Console.WriteLine("Please enter the details for the new case:");
            Console.Write("Case ID: ");
            string caseId = Console.ReadLine();
            Console.Write("Client Name: ");
            string clientName = Console.ReadLine();
            Console.Write("Description: ");
            string description = Console.ReadLine();

            // Code to save the case details to the database (Azure SQL Database) goes here

            Console.WriteLine("Case created successfully!");
        }

        static void ViewExistingCases()
        {
            // Code to fetch and display existing cases from the database (Azure SQL Database) goes here
            Console.WriteLine("List of existing cases:");
            Console.WriteLine("1. Case 123: Client A - Legal Issue 1");
            Console.WriteLine("2. Case 456: Client B - Legal Issue 2");
            // ...

            // Add more cases or implement pagination if needed

            Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
        }
    }
}

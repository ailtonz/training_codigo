using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication1
{
    class ReadFromFile
    {
        public void readFirstLine()
        {
            // The files used in this example are created in the topic
            // How to: Write to a Text File. You can change the path and
            // file name to substitute text files of your own.

            // Example #1
            // Read the file as one string.
            string text = System.IO.File.ReadLines(@"C:\Users\a.dasilva\Desktop\file_car\CAR_FIXA_PJ_CORP_20160514.txt").First();
            

            // Display the file contents to the console. Variable text is a string.
            System.Console.WriteLine(text);

            string[] words = text.Split(';');

            foreach (string word in words)
            {
                Console.WriteLine(word);
            }




            //// Example #2
            //// Read each line of the file into a string array. Each element
            //// of the array is one line of the file.
            //string[] lines = System.IO.File.ReadAllLines(@"C:\Users\Public\TestFolder\WriteLines2.txt");

            //// Display the file contents by using a foreach loop.
            //System.Console.WriteLine("Contents of WriteLines2.txt = ");
            //foreach (string line in lines)
            //{
            //    // Use a tab to indent each line of the file.
            //    Console.WriteLine("\t" + line);
            //}

            //// Keep the console window open in debug mode.
            //Console.WriteLine("Press any key to exit.");
            System.Console.ReadKey();
        }
    }


}



using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lists
{
    class ListsExemplo
    {
        static void Main()
        {
            //
            // Add rows and columns to the List.
            //
            List<List<int>> list = new List<List<int>>();
            var rand = new Random();
            for (int i = 0; i < 10; i++)
            {
                //
                // Put some integers in the inner lists.
                //
                List<int> sublist = new List<int>();
                int top = rand.Next(1, 15);
                for (int v = 0; v < top; v++)
                {
                    sublist.Add(rand.Next(1, 5));
                }
                //
                // Add the sublist to the top-level List reference.
                //
                list.Add(sublist);
            }
            //
            // Display the List.
            //
            Display(list);
        }

        static void Display(List<List<int>> list)
        {
            //
            // Display everything in the List.
            //
            Console.WriteLine("Elements:");
            foreach (var sublist in list)
            {
                foreach (var value in sublist)
                {
                    Console.Write(value);
                    Console.Write(' ');
                }
                Console.WriteLine();
            }
            //
            // Display element at 3, 3.
            //
            if (list.Count > 3 &&
            list[3].Count > 3)
            {
                Console.WriteLine("Element at 3, 3:");
                Console.WriteLine(list[3][3]);
            }
            //
            // Display total count.
            //
            int count = 0;
            foreach (var sublist in list)
            {
                count += sublist.Count;
            }
            Console.WriteLine("Count:");
            Console.WriteLine(count);
            Console.ReadKey(); // pause
        }
    }

    

}

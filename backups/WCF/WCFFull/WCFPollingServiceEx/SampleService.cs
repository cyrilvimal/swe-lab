using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace WCFPollingServiceEx
{
    public class SampleService : ISampleService
    {
        public string GreetMe(Person person)
        {
            return string.Format("Greetings from Sample service Mr. {0}", person.Name);
        }
    }

    [DataContract]
    public class Person
    {
        [DataMember]
        public string Name { get; set; }
    }
}

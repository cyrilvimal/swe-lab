using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

// ALL 3 for Remoting Hosting ability present inside System.Runtime.Remoting.dll
using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Channels.Tcp;

namespace RemotingServiceHost
{
    class Program
    {
        static void Main(string[] args)
        {
            HelloRemotingService.HelloRemotingService remotingservice = new HelloRemotingService.HelloRemotingService();
            TcpChannel channel = new TcpChannel(8080);
            ChannelServices.RegisterChannel(channel);
            RemotingConfiguration.RegisterWellKnownServiceType(typeof(HelloRemotingService.HelloRemotingService),
                "GetMessage", WellKnownObjectMode.Singleton); // SingleCall ==> can create single instance at a time and dont store the state of the object between multiple calls

            Console.WriteLine(string.Format("Remoting Service Started...{0}",DateTime.Now));
            Console.ReadLine();
        }
    }
}

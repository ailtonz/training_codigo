using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(BPO.GCash.Web.Startup))]
namespace BPO.GCash.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}

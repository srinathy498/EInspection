using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(E_Inspection.Startup))]
namespace E_Inspection
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}

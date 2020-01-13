using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BPO.Arquitetura.Autenticacao.BPO
{
    public class BPOApplicationUserManager : UserManager<BPOUser, int>
    {
        public BPOApplicationUserManager(IUserStore<BPOUser, int> store)
            : base(store)
        {
        }

        public static BPOApplicationUserManager Create(IdentityFactoryOptions<BPOApplicationUserManager> options, IOwinContext context)
        {
            var manager = new BPOApplicationUserManager(new BPOUserStore(context.Get<BPOApplicationDbContext>()));
            manager.UserValidator = new UserValidator<BPOUser, int>(manager)
            {
                AllowOnlyAlphanumericUserNames = true,
                RequireUniqueEmail = true
            };

            manager.PasswordValidator = new PasswordValidator
            {
                RequiredLength = 6,
                RequireNonLetterOrDigit = false,
                RequireDigit = true,
                RequireLowercase = true,
                RequireUppercase = true
            };

            var dataProtectionProvider = options.DataProtectionProvider;

            if (dataProtectionProvider != null)
            {
                manager.UserTokenProvider =
                    new DataProtectorTokenProvider<BPOUser, int>(dataProtectionProvider.Create("BPO.Identity"));
            }

            return manager;
        }
    }
}

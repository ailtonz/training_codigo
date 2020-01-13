using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BPO.Arquitetura.Autenticacao.BPO
{
    public class BPOApplicationDbContext : IdentityDbContext<BPOUser, BPORole, int, BPOUserLogin, BPOUserRole, BPOUserClaim>, IDisposable
    {
        public BPOApplicationDbContext()
            : base("BPO.Identity")
        {
        }


    }
}

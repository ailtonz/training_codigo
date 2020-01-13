using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BPO.Arquitetura.Autenticacao.BPO
{
    public class BPOUserStore : UserStore<BPOUser, BPORole, int, BPOUserLogin, BPOUserRole, BPOUserClaim>
    {
        public BPOUserStore(BPOApplicationDbContext context)
            : base(context)
        {

        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BPO.Arquitetura.Negocio.Model
{
    public interface IBPONegocioSaida
    {
        List<string> ErrorList { get; }
    }
}

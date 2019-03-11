using System;
using System.Collections.Generic;
using System.Text;

namespace Comun
{
    public interface IValidatable
    {
        bool Validate();
        bool Validate(int campo);
    }
}

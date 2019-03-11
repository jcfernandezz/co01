using System;
using System.Collections.Generic;
using System.Text;

namespace Comun
{
    public class Validator
    {
        private IValidatable _validatableObject;

        public Validator(IValidatable validatableObject)
        {
            _validatableObject = validatableObject;
        }

        public bool Validate()
        {
            if (_validatableObject == null)
                return false;//-- or you can throw error here

            return _validatableObject.Validate();
        }
    }
}

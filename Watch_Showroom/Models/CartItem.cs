using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class CartItem
{
    public CartItem() { }

    public CartItem(Watch Watch, int quantity)
    {
        this.Watch = Watch;
        this.Quantity = quantity;
    }

    public Watch Watch { get; set; }
    public int Quantity { get; set; }

    public void AddQuantity(int quantity)
    {
        this.Quantity += quantity;
    }

    public string Display()
    {
        string displayString = string.Format("{0} ({1} at {2})",
            Watch.Name, 
            Quantity.ToString(),
            Watch.UnitPrice.ToString("c")
        );
        return displayString;
    }
}

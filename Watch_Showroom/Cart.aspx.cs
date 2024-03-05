using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Watch_Showroom
{
    public partial class Cart : System.Web.UI.Page
    {
        private CartItemList cart;

        protected void Page_Load(object sender, EventArgs e)
        {
            cart = CartItemList.GetCart();
            if (!IsPostBack)
            {
                this.DisplayCart();
                Master.AddBreadcrumbLink("/Order.aspx", "Home");
                Master.AddCurrentPage("Cart");
            }
        }

        private void DisplayCart()
        {
            lstCart.Items.Clear();
            CartItem item;
            decimal totalCart = 0;
            for (int i = 0; i < cart.Count; i++)
            {
                item = cart[i];
                lstCart.Items.Add(item.Display());
                totalCart += item.Watch.UnitPrice * item.Quantity;
            }
            lblTotalCart.Text = Decimal.Round(totalCart,2).ToString();
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            if (cart.Count > 0)
            {
                if (lstCart.SelectedIndex > -1)
                {
                    cart.RemoveAt(lstCart.SelectedIndex);
                    this.DisplayCart();
                }
                else
                {
                    lblMessage.Text = "Please select the item you want to remove.";
                }
            }
        }

        protected void btnEmpty_Click(object sender, EventArgs e)
        {
            if (cart.Count > 0)
            {
                cart.Clear();
                lstCart.Items.Clear();
            }
        }

        protected void btnCheckOut_Click(object sender, EventArgs e)
        {
            HttpCookie firstName = Request.Cookies["FirstName"];
            if (firstName != null)
            {
                Response.Redirect("~/CheckOut.aspx");
            } else
            {
                Response.Redirect("~/Login.aspx");
            }
            
        }
    }
}
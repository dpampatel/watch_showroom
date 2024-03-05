using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
// make sure to include this namespace
using System.Data;

namespace Watch_Showroom
{
    public partial class Order : System.Web.UI.Page
    {
        private Watch selectedWatch;

        protected void Page_Load(object sender, EventArgs e)
        {
            //bind dropdown on first load; get and show Watch data on every load   
            if (!IsPostBack)
            {
                ddlWatch.DataBind();
                if (!string.IsNullOrEmpty(Request.QueryString["WatchID"]))
                {
                    string selectedWatchID = Request.QueryString["WatchID"];
                    ddlWatch.SelectedValue = selectedWatchID;
                    
                }
                Master.AddBreadcrumbLink("/Order.aspx", "Home");
            }
            selectedWatch = this.GetSelectedWatch();
            lblName.Text = selectedWatch.Name;
            lblShortDescription.Text = selectedWatch.ShortDescription; 
            lblLongDescription.Text = selectedWatch.LongDescription;
            lblUnitPrice.Text = selectedWatch.UnitPrice.ToString("c") + " each";
            imgWatch.ImageUrl = "Images/Watch/" + selectedWatch.ImageFile;
            
            HttpCookie firstName = Request.Cookies["FirstName"];
            if (firstName != null)
            {
                lblWelcome.Text = "<h4>welcome back, " + firstName.Value + "!</h4>";
            }
        }

        private Watch GetSelectedWatch()
        {
            //get row from AccessDataSource based on value in dropdownlist
            DataView WatchTable = (DataView)
                SqlDataSource1.Select(DataSourceSelectArguments.Empty);
            WatchTable.RowFilter =
                "WatchID = '" + ddlWatch.SelectedValue + "'";
			DataRowView row = WatchTable[0];

            //create a new Watch object and load with data from row
            Watch p = new Watch();
            p.WatchID = row["WatchID"].ToString();
            p.Name = row["Name"].ToString();
            p.ShortDescription = row["ShortDescription"].ToString();
            p.LongDescription = row["LongDescription"].ToString();
            p.UnitPrice = (decimal)row["UnitPrice"];
            p.ImageFile = row["ImageFile"].ToString();
            return p;
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                //get cart from session and selected item from cart
                CartItemList cart = CartItemList.GetCart();
                CartItem cartItem = cart[selectedWatch.WatchID];

                //if item isn’t in cart, add it; otherwise, increase its quantity
                if (cartItem == null)
                {
                    cart.AddItem(selectedWatch,
                                 Convert.ToInt32(txtQuantity.Text));
                }
                else
                {
                    cartItem.AddQuantity(Convert.ToInt32(txtQuantity.Text));
                }
                Response.Redirect("Cart.aspx");
            }
        }
    }
}
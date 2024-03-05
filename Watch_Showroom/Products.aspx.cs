using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Watch_Showroom
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Master.AddBreadcrumbLink("/Order.aspx", "Home");

            string header = "Our Watches";
            string TypeID = Request.QueryString["TypeID"];

            // assign data source based on whether there's a TypeID query string value
            if (string.IsNullOrEmpty(TypeID))
            {
                Repeater1.DataSourceID = "SqlDataSourceAll";
                Master.AddCurrentPage("Watches");
                header += " - All";
                Master.AddCurrentPage("All");
            }  
            else
            {
                Repeater1.DataSourceID = "SqlDataSourceByCategory";
                Master.AddBreadcrumbLink("/Products.aspx", "Watches");

                // amend header string to include category 
                switch (TypeID)
                {
                    case "WT005":
                        header += " - Smart";
                        Master.AddCurrentPage("Smart");
                        break;
                    case "WT001":
                        header += " - Sport";
                        Master.AddCurrentPage("Sport");
                        break;
                    case "WT002":
                        header += " - Dress";
                        Master.AddCurrentPage("Dress");
                        break;
                    case "WT003":
                        header += " - Casual";
                        Master.AddCurrentPage("Casual");
                        break;
                    case "WT004":
                        header += " - Chronograph";
                        Master.AddCurrentPage("Chronograph");
                        break;
                    default:
                        header += " - All";
                        Master.AddCurrentPage("All");
                        break;
                }
            }

            // set page header text 
            Master.HeaderText = header;
        }

        protected void btnBuyProduct_Click(object sender, EventArgs e)
        {

            Button btnBuyProduct = (Button)sender;
            string WatchID = btnBuyProduct.CommandArgument;
            Response.Redirect($"~/Order.aspx?WatchID={WatchID}");
        }
    }
}
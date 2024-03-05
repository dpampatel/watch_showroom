using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Watch_Showroom
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpCookie firstName = Request.Cookies["FirstName"];
                HttpCookie lastName = Request.Cookies["LastName"];
                txtFirstName.Text = firstName?.Value;
                txtLastName.Text = lastName?.Value;
                Master.AddBreadcrumbLink("/Order.aspx", "Home");
                Master.AddCurrentPage("Login");
                if (firstName != null)
                {
                    btnContinue.Visible = false;
                    btnLogout.Visible = true;
                }
                else
                {
                    btnContinue.Visible = true;
                    btnLogout.Visible = false;
                }
                if(Session["isAdmin"] != null && (bool)Session["isAdmin"])
                {
                    txtUserName.Text = (String)Session["UserName"];
                    btnContinueAdmin.Visible = false;
                    btnLogoutAdmin.Visible = true;
                    divPassword.Visible = false;
                }
                else
                {
                    btnContinueAdmin.Visible = true;
                    btnLogoutAdmin.Visible = false;
                    divPassword.Visible = true;
                }
            }
            
        }
        protected void btnContinueAdmin_Click(object sender, EventArgs e)
        {
            DataView adminData = (DataView)SqlDataSourceAdmin.Select(DataSourceSelectArguments.Empty);

            if (adminData.Count > 0)
            {
                Session["isAdmin"] = true;
                Session["UserName"] = txtUserName.Text;
                Response.Redirect("~/Admin.aspx");
            }
            else
            {
                lblAdminLoginError.Text = "Invalid username or password for Admin.";
            }
        }

        protected void btnLogoutAdmin_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                Session.Clear();
                Session.Abandon();
            }
            Response.Redirect("~/Login.aspx");
        }
        protected void btnContinue_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                DateTime expiry = DateTime.Now.AddMinutes(5);
                SetCookie("FirstName", txtFirstName.Text, expiry);
                SetCookie("LastName", txtLastName.Text, expiry);
            }
            Response.Redirect("~/Order.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                if (Request.Cookies["FirstName"] != null)
                {
                    Response.Cookies["FirstName"].Expires = DateTime.Now.AddDays(-1);
                }
                if (Request.Cookies["LastName"] != null)
                {
                    Response.Cookies["LastName"].Expires = DateTime.Now.AddDays(-1);
                }
            }
            Response.Redirect("~/Order.aspx");
        }

        private void SetCookie(string name, string value, DateTime expiry)
        {
            HttpCookie cookie = new HttpCookie(name, value);
            cookie.Expires = expiry;
            Response.Cookies.Add(cookie);
        }
    }
}


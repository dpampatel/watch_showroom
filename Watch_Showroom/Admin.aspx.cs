using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Watch_Showroom
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsAdminAuthenticated())
            {
                Response.Redirect("~/Login.aspx"); ;
            }
            if (!IsPostBack)
            {
                Master.AddBreadcrumbLink("/Admin.aspx", "Admin");
            }
        }
        private bool IsAdminAuthenticated()
        {
            if (Session["isAdmin"] != null && (bool)Session["isAdmin"] == true)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        protected void grdWatch_PreRender(object sender, EventArgs e)
        {
            grdWatch.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void dvWatch_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                lblError.Text = DatabaseErrorMessage(e.Exception.Message);
                e.ExceptionHandled = true;
                e.KeepInEditMode = true;
            }
            else if (e.AffectedRows == 0)
                lblError.Text = ConcurrencyErrorMessage();
            else
                grdWatch.DataBind();
        }

        protected void dvWatch_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                lblError.Text = DatabaseErrorMessage(e.Exception.Message);
                e.ExceptionHandled = true;
            }
            else if (e.AffectedRows == 0)
                lblError.Text = ConcurrencyErrorMessage();
            else
                grdWatch.DataBind();
        }

        protected void dvWatch_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (e.Exception != null)
            {
                lblError.Text = DatabaseErrorMessage(e.Exception.Message);
                e.ExceptionHandled = true;
                e.KeepInInsertMode = true;
            }
            else
                grdWatch.DataBind();
        }

        protected void dvWatch_ItemDeleting(object sender, DetailsViewDeleteEventArgs e)
        {
            if (e.Values["UnitPrice"] != null)
                e.Values["UnitPrice"] =
                    e.Values["UnitPrice"].ToString().Substring(1);
        }

        protected void grdCategories_PreRender(object sender, EventArgs e)
        {
            grdCategories.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                var parameters = SqlDataSource21.InsertParameters;
                parameters["TypeID"].DefaultValue = txtID2.Text;
                parameters["ShortName"].DefaultValue = txtShortName2.Text;
                parameters["LongName"].DefaultValue = txtLongName2.Text;

                try
                {
                    SqlDataSource21.Insert();
                    txtID2.Text = "";
                    txtShortName2.Text = "";
                    txtLongName2.Text = "";
                }
                catch (Exception ex)
                {
                    lblError.Text = DatabaseErrorMessage(ex.Message);
                }
            }
        }

        protected void grdCategories_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                lblError.Text = DatabaseErrorMessage(e.Exception.Message);
                e.ExceptionHandled = true;
                e.KeepInEditMode = true;
            }
            else if (e.AffectedRows == 0)
            {
                lblError.Text = ConcurrencyErrorMessage();
            }
        }

        protected void grdCategories_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                lblError.Text = DatabaseErrorMessage(e.Exception.Message);
                e.ExceptionHandled = true;
            }
            else if (e.AffectedRows == 0)
            {
                lblError.Text = ConcurrencyErrorMessage();
            }
        }

        private string DatabaseErrorMessage(string errorMsg)
        {
            return $"<b>A database error has occurred:</b> {errorMsg}";
        }
        private string ConcurrencyErrorMessage()
        {
            return "Another user may have updated that Type. Please try again";
        }

        protected void dlWatch_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void dvWatch_PageIndexChanging(object sender, DetailsViewPageEventArgs e)
        {

        }
    }
}
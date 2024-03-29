﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
// make sure to include this namespace
using System.Web.UI.HtmlControls;
using System.Reflection;

namespace Watch_Showroom
{
    public partial class Site : System.Web.UI.MasterPage
    {
        public string HeaderText {
            set { lblPageHeader.Text = value;  }
        }
        public void AddBreadcrumbLink(string url, string text)
        {
            litBreadcrumb.Text += $"<li><a href='{url}'>{text}</a></li>";
        }
        public void AddCurrentPage(string text)
        {
            litBreadcrumb.Text += $"<li class='active'>{text}</li>";
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Page.MaintainScrollPositionOnPostBack = true;
            navAdmin.Visible = IsAdminVisible();
            if (!IsPostBack) // do on initial load
            {
                // loop the navigation li elements to mark the active page 
                foreach (Control ctl in navList.Controls)
                {
                    if (ctl is HtmlGenericControl)
                    {
                        // get the current li element and its child <a> element
                        var li = (HtmlGenericControl)ctl;
                        var a = (HyperLink)li.Controls[1];

                        // if the current navigation li element is the active page...
                        if (Page.AppRelativeVirtualPath.Contains(a.NavigateUrl))
                        {
                            // set Bootstrap active class
                            li.Attributes.Add("class", "active");

                            return; // exit loop because we've marked the current navigation link as active 
                        }
                    }
                }


            }


        }

        // set cart count in PreRender event handler because count 
        // can get out of sync if set it in Load
        protected void Page_PreRender(object sender, EventArgs e)
        {
            var count = 0;
            for (int i = 0; i < CartItemList.GetCart().Count; i++)
            {
                count += CartItemList.GetCart()[i].Quantity;
            }
            spanCount.InnerText = count.ToString();
            //spanCount.InnerText = CartItemList.GetCart().Count.ToString();
        }
        protected bool IsAdminVisible()
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

    }
}
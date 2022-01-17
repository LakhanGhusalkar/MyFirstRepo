using BTEApplication.Helpers.LogFile;
using BTEApplication.Logics;
using BTEDataLibrary;
using BTEDataLibrary.DataAccess;
using log4net;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTEApplication.AdminPanel
{
    public partial class VisionDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ILog logger = LogFileHelper.GetLogger(this.GetType());
            try
            {
                if (Session["LoggedInUserId"] == null)
                {
                    Response.Redirect("~/Login.aspx", false);
                    return;
                }
                if (!IsPostBack)
                {
                    loadData();
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            ILog logger = LogFileHelper.GetLogger(this.GetType());
            try
            {
                Vision vision = new Vision();
                vision.VideoPath = txtVideoPath.Text.Trim();
                vision.VisionText = hdnData.Value;
                vision.CompanyId = Convert.ToInt32(Session["CompanyId"]);
                vision.CreatedBy = Convert.ToInt32(Session["LoggedInUserId"]);
                vision.ModifiedBy = Convert.ToInt32(Session["LoggedInUserId"]);
                string genesisImage = string.Empty;
                if (visionFileUpload.HasFile)
                {
                    if (!string.IsNullOrEmpty(visionFileUpload.PostedFile.FileName))
                    {
                        string ext = System.IO.Path.GetExtension(this.visionFileUpload.PostedFile.FileName);
                        Int32 lenght = Convert.ToInt32(ConfigurationManager.AppSettings["Img500"]);
                        string ext1 = System.IO.Path.GetExtension(this.visionFileUpload.PostedFile.FileName);
                        if (GeneralFunctions.getSizeInKB(visionFileUpload.PostedFile.ContentLength) > lenght)
                        {
                            WebMessageBox.showSweetHTMLMessage("Warning!", "Slider Image size should be less than " + lenght + " KB ", this, "");
                            return;
                        }
                        else if (ext1.ToUpper().Trim() != ".JPG" && ext1.ToUpper() != ".PNG" && ext1.ToUpper() != ".JPEG")
                        {
                            WebMessageBox.showSweetHTMLMessage("Warning!", "Please choose only .jpg, .png and .gif image types for slider!", this, "");
                            return;
                        }
                        genesisImage = "/Assets/ApplicationData/" + Session["CompanyName"].ToString() + "/Genesis/genesisImage" + DateTime.Now.ToString("dd-MM-yyyy-HH-mm-ss") + "_" + visionFileUpload.PostedFile.FileName;
                        GeneralFunctions function = new GeneralFunctions();
                        if (function.saveFile(genesisImage, visionFileUpload))
                        {
                            vision.ImagePath = genesisImage;
                        }
                    }
                }

                bool IsRecordSaved = VisionDataAccess.ManageVision(vision);
                if (IsRecordSaved)
                {
                    WebMessageBox.showSweetSuccessMessage("Success!", "Record saved successfully", this, "");
                    return;
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex);
            }
        }

        private void loadData()
        {
            ILog logger = LogFileHelper.GetLogger(this.GetType());
            try
            {
                Vision vision = VisionDataAccess.getByCompanyId(Convert.ToInt32(Session["CompanyId"]));
                if (vision != null)
                {
                    txtVideoPath.Text = vision.VideoPath;
                    hdnData.Value = vision.VisionText;
                    if (!string.IsNullOrEmpty(vision.ImagePath))
                    {
                        imgVision.Src = vision.ImagePath;
                    }
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex);
            }
        }
    }
}
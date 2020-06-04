using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;
using System.Web.Services;

using System.Drawing;
using MyImageConverterWrapper;
namespace WebApplication1
{
    public partial class Default : System.Web.UI.Page
    {
       
        [WebMethod]
        public static string ConvertImageFile(string strInputFile, string strOutputType, int iResizeWidth, int iResizeHeight, double iPDFScale, int iPDFStartPage, int iPDFEndPage)
        {



            MyImageConverter obj = new MyImageConverter();

            string strinputpath1 = HttpContext.Current.Server.MapPath("~/uploads/" + strInputFile);

            string strSmallImagePath = HttpContext.Current.Server.MapPath("~/smallimage/");

            string strBigImagePath = HttpContext.Current.Server.MapPath("~/bigimage/");

            //clear the files in smallimage folder
            System.IO.DirectoryInfo di = new DirectoryInfo(strSmallImagePath);

            foreach (FileInfo file in di.GetFiles())
            {
                file.Delete();
            }

            //clear the files in bigimage folder
            System.IO.DirectoryInfo di2 = new DirectoryInfo(strBigImagePath);

            foreach (FileInfo file in di2.GetFiles())
            {
                file.Delete();
            }


            int iTotalPage=obj.GetTotalPages(strinputpath1);
            bool bResult = true;
          
            for (int i = 1; i <= iTotalPage; i++)
            {
                string strThumbnailFileName = strSmallImagePath + "thumbnail" + i.ToString() + ".jpg";

                string strBigFileName = strBigImagePath +  i.ToString() + ".jpg";

                //if input file is pdf, set to specific page for export
                obj.PDFStartPage = i;
                obj.PDFEndPage = i;
                obj.PDFScale = iPDFScale;
                /// output thumbnail images
                bResult = obj.ConvertToImage(strinputpath1, strThumbnailFileName, 390, 518,i);
                /// output big images
                bResult = obj.ConvertToImage(strinputpath1, strBigFileName,i);

            }


            if (bResult)
                return "Convert Completed";
            else
                return "Convert Image Failed";


          
        }
        

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
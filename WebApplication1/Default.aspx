<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1.Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Image Conversion Sample</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
    <style>
        body{
            font-family: arial;
            display: flex;
            justify-content: center;
        }
        
        #container{
            min-width: 36%;
            max-width: 36%;
            word-wrap: break-word;
        }
        
        #logo{
            font-size: 3em;
        }
        
        #file{
            width: 0.1px;
            height: 0.1px;
            opacity: 0;
            overflow: hidden;
        }
        
        #file-name{
            font-size: 13px;
        }
        
        #console-div{
            overflow: auto;
            max-height: 16rem;
            font-family: "Courier New", Courier, monospace;
        }
        
        #upload-file{
            display: block;
            border: 1px solid clear;
        }
        
        #url-file{
            display: none;
        }
        
        #output-type{
            border: 1px solid black;
            border-radius: 5px;
            padding: 5px;
            width: 100%;
        }
        
       #pdf-scale{
            border: 1px solid black;
            border-radius: 5px;
            padding: 5px;
            width: 100%;
        }
        
        
        
        .input-div {
            margin-top: 2%;
        }
        
        .box{
            margin-top: 10px;
        }
        
         .short-text-box{
            border: 1px solid black;
            border-radius: 5px;
            padding: 5px;
            width: 10%;
            width: calc(10% - 2px);
        }
         .browse-text-box{
            border: 1px solid black;
            border-radius: 5px;
            padding: 5px;
            width: 80%;
            width: calc(80% - 10px);
        }
        .text-box{
            border: 1px solid black;
            border-radius: 5px;
            padding: 5px;
            width: 98%;
            width: calc(100% - 10px);
        }
        text-box-disable
        {
            background: #dddddd;
            border: 1px solid black;
            border-radius: 5px;
            padding: 5px;
            width: 98%;
            width: calc(100% - 10px);
        }
        .invalid{
            
            border: 2px solid red ! important;
        }
        
        .btn
        {
            padding: 5px;
            border: 2px solid grey;
            border-radius: 5px;
            background-color: rgb(230,230,230);
            font-size: 14px;
        }
        .disabled {
              pointer-events: none;  /**<-----------*/
            opacity: 0.2;
        }
        .btn:hover{
            border: 2px solid black;
            border-radius: 5px;
            background-color: rgba(0,0,0,0);
            cursor: pointer;
        }
        
       .switch {
            position: relative;
            display: inline-block;
        }
       .switch-input {
            display: none;
        }
        .switch-label {
            display: block;
            width: 48px;
          height: 24px;
          text-indent: -150%;
          clip: rect(0 0 0 0);
          color: transparent;
          user-select: none;
        }
        .switch-label::before,
        .switch-label::after {
          content: "";
          display: block;
          position: absolute;
          cursor: pointer;
        }
        .switch-label::before {
          width: 100%;
          height: 100%;
          background-color: #dedede;
          border-radius: 9999em;
          -webkit-transition: background-color 0.25s ease;
          transition: background-color 0.25s ease;
        }
        .switch-label::after {
          top: 0;
          left: 0;
          width: 24px;
          height: 24px;
          border-radius: 50%;
          background-color: #fff;
          box-shadow: 0 0 2px rgba(0, 0, 0, 0.45);
          -webkit-transition: left 0.25s ease;
          transition: left 0.25s ease;
        }
        .switch-input:checked + .switch-label::before {
          background-color: #89c12d;
        }
        .switch-input:checked + .switch-label::after {
          left: 24px;
        }
    </style>
    <script type="text/javascript">
        var files1;
        var files2;

        $(document).ready(function () {

         
           $("#file").change(OnChange1);
         
            $("#btnUpload").click(UploadFiles);
            $("#btnConvertImage").click(ConvertImageFiles);
            $("#btnUpload").attr("disabled", "disabled");
            $("#btnConvertImage").attr("disabled", "disabled");
             
             document.getElementById('TxtResizeWidth').disabled = true;
             document.getElementById('TxtResizeHeight').disabled = true;
             document.getElementById('TxtPDFStartPage').disabled = true;
             document.getElementById('TxtPDFEndPage').disabled = true;



        });

          $(function () {

       

          $("#dialog-upload" ).dialog({
               autoOpen: false, 
               modal: true,
               buttons: {
                  OK: function() {$(this).dialog("close");}
               },
            });


          $("#dialog-image" ).dialog({
               autoOpen: false, 
               modal: true,
               buttons: {
                  OK: function() {$(this).dialog("close");}
               },
            });


     });


    

        function OnChange1(evt) {
            files1 = evt.target.files;
               $("#btnUpload").removeAttr("disabled");

            document.getElementById("file-name").value = files1[0].name;
            document.getElementById('btnUpload').disabled = false;

        }
        

        function ConvertImageFiles() {

            var e = document.getElementById("output-type");
            var strOutputType = e.options[e.selectedIndex].value;
            
             e = document.getElementById("pdf-scale");
            var strPDFScale = e.options[e.selectedIndex].value;
            
           
       
            var obj = {};
           
             obj.strInputFile = files1[0].name;
            obj.strOutputType = strOutputType;
            obj.iResizeWidth = $("#TxtResizeWidth").val();
            obj.iResizeHeight = $("#TxtResizeHeight").val();
            obj.iPDFScale  = strPDFScale;

            if( document.getElementById("chkAllPDFPage").checked)
            {
               obj.iPDFStartPage =0;
               obj.iPDFEndPage =0;
            }
            else
            {
               obj.iPDFStartPage =$("#TxtPDFStartPage").val();
               obj.iPDFEndPage =$("#TxtPDFEndPage").val();
            }

            $.ajax({
                type: 'POST',
                url: '/Default.aspx/ConvertImageFile',
                data: JSON.stringify(obj),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (results) {
                 
                  var link='<a href=' +"/output/"+ results.d + " target='_blank'" + ">"+ results.d +"</a>";
                   $("#dialog-image").html(link).dialog("open");
        
                  },
                error: function () { alert('error'); }
            });
            
        }

        

        function chkAllPDFPageClick(cb) {
          if(cb.checked)
          {
             document.getElementById('TxtPDFStartPage').disabled = true;
             document.getElementById('TxtPDFEndPage').disabled = true;
           

          }
          else
          {
                 document.getElementById('TxtPDFStartPage').disabled = false;
                 document.getElementById('TxtPDFEndPage').disabled = false;
         
          }
        }


        
        function chkConvertImageFullPageClick(cb) {
          if(cb.checked)
          {
             document.getElementById('TxtResizeWidth').disabled = true;
             document.getElementById('TxtResizeHeight').disabled = true;
             $("#TxtResizeWidth").val(0);
             $("#TxtResizeHeight").val(0);

          }
          else
          {
              document.getElementById('TxtResizeWidth').disabled =false;
              document.getElementById('TxtResizeHeight').disabled = false;
         
          }
        }


        function UploadFiles() {

       
            var data = new FormData();
         
            data.append(files1[0].name, files1[0]);
           
         
             $("#btnUpload").attr("disabled", "disabled");

            $.ajax({
                type: "POST",
                url: "UploadFiles.ashx",
                contentType: false,
                processData: false,
                data: data,
                success: function (result) {
                     $("#dialog-upload").dialog("open");
                     $("#btnConvertImage").removeAttr("disabled");
                      $("#btnUpload").removeAttr("disabled");
                   
                },
                error: function () {
                    alert("There was error uploading files!");
                }
            });

         
        }

    </script>
</head>
<body style="">
  
 <div id="container">
        <div id="logo" class="box">
            <span>Create Thumbnail and Export Pages</span>
        </div>
        <br/>
        
        <div class="input-div">
            
            <div id="input-box">
                
                  <div class="box">
                  
                        <input id="file-name" class="browse-text-box" type="text" value=""  />
                        <input id="file" type="file" accept=".pdf, .tif, .tiff, .png, .bmp, .jpg"/>
                        <label id="browse" for="file" class="btn">Browse...</label>
                        
                    </div>


                <div class="input-div box">
                <input id="btnUpload" class="btn" type="button" value="Upload" />
                </div>

                <div class="box">
                    <span>Output Format:</span>
                    <select id="output-type" >
                    
                        <option value="JPG">JPEG</option>
                     
                    </select>
                </div>

                 <div class="box">
                    <span>PDF Scale Ratio:</span>
                    <select id="pdf-scale" >
                        <option value="1.3">1.3</option>
                        <option value="2.0">2.0</option>
                        <option value="2.5">2.5</option>
                        <option value="3.0">3.0</option>
                        
                    </select>
                </div>
            <div class="box">
                <span>Convert All PDF Pages:</span>
                  <div class="switch">
                    <input id="chkAllPDFPage" type="checkbox" class="switch-input"  Checked="True" onclick='chkAllPDFPageClick(this);' />
                    <label for="chkAllPDFPage" class="switch-label"></label>
                  </div>

                <br/>
              </div>

               <div class="box">
                <span>Convert PDF Pages By Range:</span>
                <br/>
            </div>
            <div class="box">
               
                <span>Start Page:</span>
                <input id="TxtPDFStartPage" class="short-text-box" type="text" value="1" />
                 <span>End Page:</span>
                <input id="TxtPDFEndPage" class="short-text-box" type="text" value="2" />
                <br/>
           


                 <div class="box">
                <span> Convert Image By Full Page:</span>
                  <div class="switch">
                    <input id="chkConvertImageFullPage" type="checkbox" class="switch-input"  Checked="True" onclick='chkConvertImageFullPageClick(this);' />
                    <label for="chkConvertImageFullPage" class="switch-label"></label>
                  </div>

                <br/>
              </div>
               
            <div class="box">
                <span>Convert Image By Size:</span>
                <br/>
            </div>
            <div class="box">
               
                <span>Width:</span>
                <input id="TxtResizeWidth" class="short-text-box" type="text" value="0" />
                 <span>Height:</span>
                <input id="TxtResizeHeight" class="short-text-box" type="text" value="0" />
                <br/>
            </div>

          
           
        <div class="input-div box">
       
            <input id="btnConvertImage" class="btn" type="button" value="Convert Image" />
        </div>
        <br/>
        <div id="console-div" ></div>
    </div>


  

  <div id="dialog-image" title="Image File">
    </div>
<div id = "dialog-upload" title = "Upload">File Uploaded Successfully!</div>
</body>
</html>

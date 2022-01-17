<%@ Page Title="" Language="C#" ValidateRequest="false" MasterPageFile="~/AdminPanel/Admin.Master" AutoEventWireup="true" CodeBehind="VisionDetails.aspx.cs" Inherits="BTEApplication.AdminPanel.VisionDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Assets/BackEnd/Plugin/sweetalert/sweetalert.css" rel="stylesheet" />
    <link href="/Assets/Common/Common.css" rel="stylesheet" />
    <!-- summernote -->
    <link href="/Assets/BackEnd/ThemeAssets/plugins/summernote/summernote-bs4.min.css" rel="stylesheet" />
    <!-- CodeMirror -->
    <link rel="stylesheet" href="/Assets/BackEnd/ThemeAssets/plugins/codemirror/codemirror.css">
    <link rel="stylesheet" href="/Assets/BackEnd/ThemeAssets/plugins/codemirror/theme/monokai.css">
    <link href="/Assets/BackEnd/ThemeAssets/plugins/summernote/summernoteStyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdnData" ClientIDMode="Static" runat="server" />
            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <div class="content-header">
                    <div class="container-fluid">
                        <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1 class="m-0">Vision Details</h1>
                            </div>
                            <!-- /.col -->
                            <div class="col-sm-6">
                                <ol class="breadcrumb float-sm-right">
                                    <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                                    <li class="breadcrumb-item active">Vision</li>
                                </ol>
                            </div>
                            <!-- /.col -->
                        </div>
                        <!-- /.row -->
                    </div>
                    <!-- /.container-fluid -->
                </div>
                <!-- /.content-header -->

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <!-- left column -->
                            <div class="col-md-8 col-sm-8 col-12">
                                <!-- general form elements -->
                                <div class="card card-primary">
                                    <div class="card-header">
                                        <h3 class="card-title">Vision Entry</h3>
                                    </div>
                                    <!-- /.card-header -->
                                    <!-- form start -->
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-12 col-md-12">
                                                <div class="form-group">
                                                    <label for="ContentPlaceHolder1_txtVideoPath">Video Path</label><%--&nbsp;<span class="compulsoryStar">*</span>--%>
                                                    <asp:TextBox ID="txtVideoPath" class="form-control" placeholder="Video Path" runat="server"></asp:TextBox>
                                                    <%--<asp:RegularExpressionValidator ControlToValidate="txtTitle" ValidationGroup="save" Display="Dynamic" ForeColor="OrangeRed" Font-Bold="true" ID="RegularExpressionValidator5" ValidationExpression="^[A-Za-z0-9 ]*$" runat="server" ErrorMessage="only characters allowed."></asp:RegularExpressionValidator>
                                                    <asp:RegularExpressionValidator ControlToValidate="txtTitle" ValidationGroup="save" Display="Dynamic" ForeColor="OrangeRed" Font-Bold="true" ID="RegularExpressionValidator1" ValidationExpression="^[\s\S]{1,15}$" runat="server" ErrorMessage="Maximum 15 characters allowed."></asp:RegularExpressionValidator>
                                                    <asp:RequiredFieldValidator ControlToValidate="txtTitle" ValidationGroup="save" Display="Dynamic" ForeColor="OrangeRed" Font-Bold="true" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Field is required"></asp:RequiredFieldValidator>--%>
                                                </div>
                                            </div>
                                            
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword1">Vision Descriptions</label>&nbsp;<span class="compulsoryStar">*</span>
                                            <div id="summernote">
                                            </div>
                                        </div>

                                    </div>
                                    <!-- /.card-body -->
                                    <div class="card-footer">
                                        <asp:Button ID="btnSave" runat="server" class="btn btn-primary Submit-Button float-right " Text="Save" OnClientClick="ValidatePage();setValue();" OnClick="btnSave_Click" />
                                        <span class="Postback-Loader float-right">
                                            <img src="/Assets/Common/img/Defaults/loading.gif" class="Img-Loading" />Please wait
                                        </span>
                                    </div>
                                </div>
                                <!-- /.card -->
                            </div>

                            <div class="col-md-4 col-sm-4 col-12">
                                <!-- general form elements -->
                                <div class="card card-primary">
                                    <div class="card-header">
                                        <h3 class="card-title">Vision Image</h3>
                                    </div>
                                    <!-- /.card-header -->
                                    <!-- form start -->
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-12 col-md-12">
                                                <div class="form-group">
                                                    <label for="ContentPlaceHolder1_txtTitle">Image</label>&nbsp;<span class="compulsoryStar">*</span>
                                                    <div class="hvrbox" style="cursor: pointer; width: 100%;">
                                                        <img id="imgVision" runat="server" src="/Assets/Common/img/Defaults/aboutus.png" class="hvrbox-layer_bottom img-fluid img-thumbnail visionImage" style="min-height: 225px; max-height: 225px; max-width: 440px; min-width: 205px;" />
                                                        <asp:FileUpload ID="visionFileUpload" onchange="showImagePreview(this, '.visionImage');" class="visionFileUpload compulsoryProfilePhoto15KB" Style="display: none" runat="server" />
                                                        <div class="hvrbox-layer_top" onclick="showFileUpload('.visionFileUpload');">
                                                            <div class="hvrbox-text">
                                                                Upload Vision
                                                        <br />
                                                                Max Size (500KB)
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.card-body -->
                                    <div class="card-footer">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
        </Triggers>
    </asp:UpdatePanel>
    <!-- jQuery -->
    <script src="/Assets/BackEnd/ThemeAssets/plugins/jquery/jquery.min.js"></script>
    <script src="/Assets/Common/validatePage.js"></script>
    <!-- Summernote -->
    <script src="/Assets/BackEnd/ThemeAssets/plugins/summernote/summernote-bs4.min.js"></script>
    <script src="/Assets/BackEnd/ThemeAssets/plugins/summernote/summernoteCall.js"></script>
    <script src="/Assets/BackEnd/Plugin/sweetalert/sweetalert.min.js"></script>
    <script src="/Assets/Common/common.js"></script>
    <script>
    </script>
</asp:Content>

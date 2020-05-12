<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VIQForm.aspx.cs" MasterPageFile="~/Site.Master" Inherits="E_Inspection.Forms.VIQForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="<%= Page.ResolveClientUrl("~/scripts/jquery-3.3.1.min.js") %>"></script>
    <script type="text/javascript">
        function show(id) {
            $(".tbldiv").hide();   
            $('.lbldiv').hide();
            $('#' + id).show();
            $('#lbl' + id).show();

        }
    </script>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
   <div>
        <div class="content-wrapper">
          <div class="row">            
            <div class="col-12 grid-margin stretch-card">
              <div class="card">
                  <h4 class="card-title">FORM</h4>
                <div class="">
                   <br />           
                    <label class="col-form-label text-danger" id="lblerror" runat="server"></label>
                    <div class="row" style="background-color:white;height:100%">
                        <div class="col-xs-3 col-md-5" style="max-height:calc(100vh);overflow-y:auto;overflow-x:hidden;">
                            <table class="responsive tbldiv" style="width:100%" id="tbl1">
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios" checked>

                                                    1.1 Three equal-width columns starting at tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios">

                                                    1.2 Starting at tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios">

                                                    1.3 Columns starting at tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios">
                                                    1.4 Tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios">
                                                    1.5 Tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios">
                                                    1.6 Tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios">
                                                    1.7 Tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios">
                                                    1.7 Tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios">
                                                    1.7 Tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios">
                                                    1.7 Tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios">
                                                    1.7 Tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <table class="responsive tbldiv" style="width:100%;display:none;" id="tbl2">
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios3" checked>
                                                    2.1 Tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios3">
                                                    2.2 Tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios3">
                                                    2.3 Tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios3">
                                                    2.4 Tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios3">
                                                    2.5 Tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios3">
                                                    2.6 Tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input type="radio" class="form-check-input" name="optionsRadios3">
                                                    2.7 Tablets and scaling to large desktops. On mobile phones, the columns will automatically stack
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="col-xs-9 col-md-7">
                           
                            <div class="lbldiv" id="lbltbl1">
                                <h4 class="card-title">1.1 Name of the vessel:</h4> 
                                <br />
                                <br />                                
                                    <div class="form-group">
                                        <label for="exampleInputName1">COSGRANA LAKE</label>
                                        <input type="text" class="form-control" id="exampleInputName1" placeholder="Name">
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleTextarea1">COMMENTS</label>
                                        <textarea class="form-control" id="exampleTextarea1" rows="4"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleTextarea1" style="background-color:aliceblue">
                                            Guidance: <br />
                                            Note: Prefixes (MT, MY, SS etc.) must not be used unless they are actually a part of the registred name of the vessel. The name must be entered exactly as it appears on the certicate of Registry.
                                        </label>
                                    </div>
                                    <!--<button type="submit" class="btn btn-primary mr-2">Submit</button>
                        <button class="btn btn-light">Cancel</button>-->
                               
                            </div>
                            <div class="lbldiv" id="lbltbl2" style="display:none;"> 
                                <h4 class="card-title lbldiv1">2.1 Test:</h4> 
                                <br />
                                <br />
                                    <div class="form-group row">
                                        <div class="form-check">
                                            <label class="form-check-label">
                                                <input type="radio" class="form-check-input" name="optionsRadios2" id="optionsRadios1" value="" checked>
                                                Yes &nbsp;
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <label class="form-check-label">
                                                <input type="radio" class="form-check-input" name="optionsRadios2" id="optionsRadios1" value="">
                                                No&nbsp;
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <label class="form-check-label">
                                                <input type="radio" class="form-check-input" name="optionsRadios2" id="optionsRadios1" value="">
                                                Not seen&nbsp;
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <label class="form-check-label">
                                                <input type="radio" class="form-check-input" name="optionsRadios2" id="optionsRadios1" value="">
                                                Not applicable
                                            </label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleTextarea1">Observations</label>
                                        <textarea class="form-control" id="exampleTextarea1" rows="4"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleTextarea1">Other inspector comments</label>
                                        <textarea class="form-control" id="exampleTextarea1" rows="4">Master's standing orders were in place and duly signed by the deck officers and these were complemented</textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleTextarea1" style="background-color:aliceblue">
                                            Guidance: <br />
                                            Note: Prefixes (MT, MY, SS etc.) must not be used unless they are actually a part of the registred name of the vessel. The name must be entered exactly as it appears on the certicate of Registry.
                                        </label>
                                    </div>                                    
                                    <a href="#" class="btn btn-primary mr-2" data-toggle="modal" data-target="#ItemModal" data-backdrop="static" data-keyboard="false" id="1"><i class="fa fa-search" aria-hidden="true"></i>Edit</a>
                                
                            </div>
                        </div>


                    </div> 
                    <div class="row">
                         <div class="col-md-8 offset-md-4">
                             <asp:Button Text="Submit" class="btn btn-primary mr-2" runat="server" ID="btnSubmit" OnClick="btnSubmit_Click" />
                             <a class="btn btn-danger" href="ShipMaster.aspx">Cancel</a> 
                         </div>
                    </div>                 
                                    
                </div>
              </div>
            </div>           
          </div>            
          </div>
      </div>
    <div class="modal fade" id="ItemModal" tabindex="-1" role="dialog" aria-labelledby="itemModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content" style="width:130%;">
                            <div class="modal-header">
                                <h5 class="modal-title" id="itemModalLabel">Edit Report Details</h5>
                                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="">
                                    <form class="forms-sample">
                                        <div class="form-group">
                                            <label for="exampleInputName1">COSGRANA LAKE</label>
                                            <input type="text" class="form-control" id="exampleInputName1" placeholder="Name" value="Testing Edit ">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleTextarea1">COMMENTS</label>
                                            <textarea class="form-control" id="exampleTextarea1" rows="4">Prefixes (MT, MY, SS etc.) must not be used unless they are actually a part </textarea>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Commissioner</label>
                                            <div class="col-sm-9">
                                                <select class="form-control">
                                                    <option>Commissioner1</option>
                                                    <option>com2</option>
                                                </select>
                                            </div>
                                        </div>                                       
                                    </form>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-primary" type="button" data-dismiss="modal">Update</button>
                                <button class="btn btn-danger" type="button" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
    <div class="modal fade" id="ShipModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="width: 130%;">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Ship Details</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="Shiptable" width="100%">
                                <thead>
                                    <tr>
                                        <th>Ship ID</th>
                                        <th>Name</th>
                                        <th>Type</th>
                                        <th>IMO No</th>    
                                        <th>DWT</th>                                   
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-danger" type="button" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    <input type="hidden" id="btnhdn" runat="server" />
   </asp:Content>

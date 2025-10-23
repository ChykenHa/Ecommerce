using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace OnlineShop
{
    public partial class CategoryManagement : System.Web.UI.Page
    {
        string connect = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\DataBase.mdf;Integrated Security=True;Connect Timeout=30;Application Name=OnlineShop";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["AdminLoggedIn"] == null || Session["AdminLoggedIn"].ToString() != "true")
                {
                    Response.Redirect("AdminLogin.aspx");
                    return;
                }

                LoadCategories();
            }
        }

        private void LoadCategories()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("CategoryId", typeof(int));
            dt.Columns.Add("CategoryName", typeof(string));
            dt.Columns.Add("Description", typeof(string));
            dt.Columns.Add("ProductCount", typeof(int));
            
            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();
                    string query = @"SELECT 
                                    lh.id_loai AS CategoryId,
                                    lh.tenloai AS CategoryName,
                                    lh.mota AS Description,
                                    COUNT(mh.id_hang) AS ProductCount
                                FROM LoaiHang lh
                                LEFT JOIN MatHang mh ON lh.id_loai = mh.id_loai
                                GROUP BY lh.id_loai, lh.tenloai, lh.mota
                                ORDER BY lh.id_loai";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(dt);
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(string.Format("Error loading categories: {0}", ex.Message));
                }
            }
            
            // If no data from database, use demo categories
            if (dt.Rows.Count == 0)
            {
                dt.Rows.Add(1, "Điện thoại", "Smartphone và điện thoại di động", 6);
                dt.Rows.Add(2, "Laptop", "Máy tính xách tay và workstation", 5);
                dt.Rows.Add(3, "Tablet", "Máy tính bảng các loại", 3);
                dt.Rows.Add(4, "Phụ kiện", "Tai nghe, chuột, bàn phím, màn hình", 6);
            }

            gvCategories.DataSource = dt;
            gvCategories.DataBind();
        }

        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtNewCategoryName.Text))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ValidationError",
                    "alert('Vui lòng nhập tên danh mục!');", true);
                return;
            }

            using (SqlConnection conn = new SqlConnection(connect))
            {
                try
                {
                    conn.Open();
                    string query = "INSERT INTO LoaiHang (tenloai, mota) VALUES (@Name, @Description)";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Name", txtNewCategoryName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Description", txtNewDescription.Text.Trim());

                    int result = cmd.ExecuteNonQuery();
                    if (result > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "Success",
                            "alert('Thêm danh mục thành công!');", true);

                        txtNewCategoryName.Text = "";
                        txtNewDescription.Text = "";
                        LoadCategories();
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "AddError",
                        string.Format("alert('Lỗi: {0}');", ex.Message.Replace("'", "\\'")), true);
                }
            }
        }
    }
}



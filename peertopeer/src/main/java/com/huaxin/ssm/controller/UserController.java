package com.huaxin.ssm.controller;
import java.io.File;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.huaxin.ssm.bean.PageBean;
import com.huaxin.ssm.bean.Role;
import com.huaxin.ssm.bean.User;
import com.huaxin.ssm.service.IRoleService;
import com.huaxin.ssm.service.IUserService;
import com.huaxin.ssm.util.FinalCodeUtil;
import com.huaxin.ssm.util.JsonUtil;
import com.huaxin.ssm.util.MD5;

import net.sf.json.JSONObject;
/** 
* @author 作者 Your-Name: 
* @version 创建时间：2019年2月15日 上午10:04:48 
* 类说明 
*/
@Controller
@RequestMapping(value="/user")
public class UserController {
	@Autowired
	private IUserService userService;
	@Autowired
	private IRoleService roleService;
/*	//跳转页面
	@RequestMapping("/toList")
	public String toList(){
		return "userManage";
	}*/
	@RequestMapping("/userManage")
	public String userManage(){
		
		return "/views/userManage";
	}
	/**
	 * 分页注意事项:
	 * 1、easyui默认会传入分页参数  page表示第几页  rows：每页记录数
	 * 2、返回数据的时候，必须设置total总记录数，rows：数据集合
	 * 3、需要满足json格式
	 * @author fdz
	 * @param request
	 * @return
	 */
	
	@RequestMapping("/Updatapassword")
	@ResponseBody
	public String Updatapassword(User user,HttpSession session){
		User u=(User)session.getAttribute("userinfo");
		String pwd=user.getPassword();
		String encryptpass=MD5.encodeMD5(u.getUsername(), pwd);
		/*String id=request.getParameter("id");
		String password=request.getParameter("password");
		User user=new User();
		user.setId(id);
		user.setPassword(password);
		*/
		int k=0;
		user.setPassword(encryptpass);
		user.setId(u.getId());
		k=userService.Updatapassword(user);
		return k+"";
	}
	
	
	@RequestMapping("/getAllUser")
	@ResponseBody
	public String getAllUser(HttpServletRequest request){
		//查询参数
		String name=request.getParameter("a");
		//分页第几页
		String pageNumber=request.getParameter("page");
		//每页记录数
		String pageSize=request.getParameter("rows");
		
		PageBean pagebean=new PageBean();
		//分页统一设置
		pagebean.setPagein(Integer.parseInt(pageNumber),Integer.parseInt(pageSize));
		
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("name", name);
		pagebean.setMap(map);
		//查询用户记录
		List<User> list=userService.getAllUser(pagebean);
		//查询总记录数
		int rowcount=userService.getUserCount(pagebean);      
		//放到分页组件中
		JSONObject jsonobj=new JSONObject();
		jsonobj.accumulate("total", rowcount);
		jsonobj.accumulate("rows", list);
		return jsonobj.toString();
	}
	
	//遍历用户配置
	@RequestMapping("/getRoleList")
	@ResponseBody
	public String getRoleList(String id){
		List<Role> list=roleService.getAllRole(null);
		String roleid=roleService.getRoleIdByUId(id);
		JSONObject jsonobj=new JSONObject();
		jsonobj.accumulate("rolelist", list);
		jsonobj.accumulate("roleid", roleid);
		return jsonobj.toString();
	}
	
	@RequestMapping("/saveUserRole")
	@ResponseBody
	public String saveUserRole(String id,String roleid){
		int n=userService.saveUserRole(id,roleid);
		return String.valueOf(n);
	}
	
	    //增加数据
		@RequestMapping("/saveOrUpdata")
		@ResponseBody
		public String saveOrUpdata(User user,HttpServletRequest req){
			
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
			int k=0;
			MultipartFile file = multipartRequest.getFile("userfile");
			//上传资料
			//调用service
			try {
				if(file!=null) {
					String filepath=FinalCodeUtil.FILE_UPLOAD_PATH;
					File f=new File(filepath);
					if(!f.exists()) {
						f.mkdirs();
					}
					//获取文件名称
					String filename=file.getOriginalFilename();
					//文件上传到指定命令
					file.transferTo(new File(f,filename));
					user.setFilepath(filepath+File.separator+filename);
				}
				//调用service
				k=userService.saveOrUpdateUser(user);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			
			//返回json 格式的数据
			return String.valueOf(k);
		}
		
		
		//删除
		@RequestMapping("/deleteUser")
		@ResponseBody
		public String deleteUser(String id){
			//2、调用service
			Map<String,Object> map=new HashMap<>();
			map.put("id", id);
			int k=userService.deleteUser(map);
			/*int k=0;
			if(StringUtils.isNotEmpty(id)){
				if(id.indexOf("|")>0){
					String[] ids=id.split("\\|");
					for(int i=0;i<ids.length;i++){
						k=userService.deleteUser(ids[i]);
					}
				}else{
					k=userService.deleteUser(id);
				}
			}*/
			
			//3、返回json 格式的数据
			return String.valueOf(k);
		}
		@RequestMapping("/getUserById")
		@ResponseBody
		public String getUserById(String id){
			User u=userService.getUserById(id);
			JSONObject jsonobj=JsonUtil.bean2Json(u);
			return jsonobj.toString();
		}
		//导出excel表
		@RequestMapping("/exportExcel")
		@ResponseBody
		public void exportExcel(String name,HttpServletResponse response){
			Map<String,Object> map=new HashMap<String,Object>();
			try {
				map.put("name",java.net.URLDecoder.decode(name,"UTF-8"));
				HSSFWorkbook wb=userService.exportExcel(map);
				String fileName = "用户信息表"+System.currentTimeMillis()+".xls";
	            fileName = new String(fileName.getBytes(),"ISO8859-1");
	            response.setContentType("application/octet-stream;charset=ISO8859-1");
	            response.setHeader("Content-Disposition", "attachment;filename="+ fileName);
	            response.addHeader("Pargam", "no-cache");
	            response.addHeader("Cache-Control", "no-cache");
	            OutputStream os = response.getOutputStream();
	            wb.write(os);
	            os.flush();
	            os.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
		}
		@RequestMapping("/downloadFile")
		public void downloadFile(String id,HttpServletResponse response){
			try {
				User user=userService.getUserById(id);
				//如果图片地址为空不执行，防止空指针问题
				if(user!=null && user.getFilepath()!=null) {
					String filepatname=user.getFilepath();
					String filename=filepatname.substring(filepatname.lastIndexOf("\\")+1,filepatname.length());
					File file=new File(filepatname);
					if(file==null || !file.exists()){
						return;
					}
					filename = new String(filename.getBytes(),"ISO8859-1");
					 response.setContentType("application/octet-stream;charset=ISO8859-1");
			            response.setHeader("Content-Disposition", "attachment;filename="+ filename);
			            response.addHeader("Pargam", "no-cache");
			            response.addHeader("Cache-Control", "no-cache");
			            OutputStream out = response.getOutputStream();
			            out.write(FileUtils.readFileToByteArray(file));
			            out.flush();
			            out.close();
				}
				
	           
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
		}
}

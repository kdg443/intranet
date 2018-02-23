package utilMade;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/downloadAction")
public class downloadAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fileName = request.getParameter("file");
		String save = request.getParameter("save");
		String upload = "/upload/";
		upload += save;		//다운로드할 파일의 위치
		
		String dir = this.getServletContext().getRealPath(upload);		//실제 위치
		File file = new File(dir + "/" + fileName);
		
		String mimeType = getServletContext().getMimeType(file.toString());
		if(mimeType == null) {
			response.setContentType("application/octet-stream");
		}
		
		String downloadName = null;
		
		//IE 판별
		if(request.getHeader("user-agent").indexOf("Trident") == -1 && 
				request.getHeader("user-agent").indexOf("MSIE") == -1) {
			downloadName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
		}else {
			downloadName = new String(fileName.getBytes("EUC-KR"), "8859_1");
		}
		
		response.setHeader( "Content-Disposition", "attachment;filename=\""
				+ downloadName + "\";" );
		
		FileInputStream fis = new FileInputStream(file);
		ServletOutputStream sos = response.getOutputStream();
		
		byte b[] = new byte[1024];
		int data = 0;
		
		while((data = (fis.read(b, 0, b.length))) != -1) {
			sos.write(b, 0, data);
		}
		
		sos.flush();
		sos.close();
		fis.close();
	}
}

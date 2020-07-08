package pdf_trial;

import java.io.FileOutputStream;

import com.itextpdf;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;

public class Reporting {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Document document = new Document(null);
		try{
			PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream("HelloWorld.pdf"));
			document.open();
			document.add(new Paragraph("Welcome to pdf"));
			document.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}

		}
	}

}

public class report_trial{
	public static void main(String args[]) {
		Document document=new Document();
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

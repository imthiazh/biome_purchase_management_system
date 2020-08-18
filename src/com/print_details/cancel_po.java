package com.print_details;

/*import com.itextpdf.layout.element.Cell;*/
import java.io.FileOutputStream;
import java.net.URL;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class cancel_po {
	// public static void main(String args[]) {
	public String main_print(int order_id, Image image, Image image2) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL database connection
			Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/inventory-equipments?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
					"root", "");
			System.out.println("part 1");
			ResultSet rs = null;
			/*
			 * PreparedStatement pst = conn.
			 * prepareStatement("SELECT `order_details`.order_id, `dept_details`.dept_name, `user_details`.full_name, `order_details`.po_No, `order_details`.q_No, `order_details`.order_no, `order_details`.ord_date, `order_details`.ord_vendor FROM `order_details`,`user_details`,`dept_details` WHERE order_details.user_id=user_details.user_id AND user_details.dept_id=dept_details.dept_id AND order_details.order_id=?"
			 * );
			 */
			PreparedStatement pst = conn.prepareStatement(
					"SELECT `order_details`.order_id, `dept_details`.dept_name, `dept_details`.dept_id, `user_details`.full_name, `order_details`.po_No, `order_details`.payment_type, `order_details`.payment_amount , `order_details`.q_No, `order_details`.q_validity"
							+ "" + ""
							+ ", `order_details`.item_list,`order_details`.vendor_address, `order_details`.grand_total, `order_details`.currency, `order_details`.ord_date, `order_details`.ord_vendor FROM `order_details`,`user_details`,`dept_details` WHERE order_details.user_id=user_details.user_id AND user_details.dept_id=dept_details.dept_id AND order_id = ?");
			/* pst.setInt(1,Integer.parseInt(request.getParameter("order_id"))); */
			// String order_id = "12";
			pst.setInt(1, order_id);
			/* pst.setInt(1,Integer.parseInt(order_id)); */
			rs = pst.executeQuery();
			rs.next();

			System.out.println("part 2");
			ResultSet rs_adddata = null;
			PreparedStatement pst_adddata = conn.prepareStatement(
					"SELECT item_name, rate, quantity, unit, cost FROM add_order_details WHERE order_id = ?");
			pst_adddata.setInt(1, order_id);
			// pst_adddata.setInt(1,Integer.parseInt(order_id));
			rs_adddata = pst_adddata.executeQuery();
			rs_adddata.next();
			/*
			 * PreparedStatement pst = conn.
			 * prepareStatement("SELECT `full_name` FROM `user_details` WHERE `user_id`=1 "
			 * ); ResultSet rs = pst.executeQuery(); rs.next(); String fn =
			 * rs.getString("full_name");
			 */
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			LocalDateTime now = LocalDateTime.now();

			/* String now1 = dtf.format(now); */
			Document document = new Document();
			System.out.println("part 3");
			document.setMargins(45, 45, 0, 0);
			PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(
					"C:\\Users\\Imthiaz\\eclipse-workspace\\inventory-equipments\\WebContent\\test\\HelloWorld12345.pdf"));

			/*
			 * PdfWriter writer = PdfWriter.getInstance(document,new
			 * FileOutputStream("HelloWorld12345.pdf"));
			 */

			document.open();

			/*
			 * Image image = Image.getInstance(
			 * "C:\\Users\\Imthiaz\\eclipse-workspace\\inventory-equipments\\WebContent\\test\\a_image.png"
			 * ); if(image==null) System.out.println("NULLLLL");
			 */
			/*
			 * Image image = Image.getInstance(
			 * "C:\\Users\\Imthiaz\\eclipse-workspace\\inventory-equipments\\WebContent\\test\\a_image.png"
			 * ); document.add(image);
			 */
			document.add(image);
			/*
			 * String imageUrl = "http://jenkov.com/images/" +
			 * "20081123-20081123-3E1W7902-small-portrait.jpg";
			 * 
			 * Image image = Image.getInstance(new URL(imageUrl));
			 */

			Paragraph head = new Paragraph("Cancellation of Purchase Order",
					FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, Font.BOLD, BaseColor.BLACK));
			head.setAlignment(Element.ALIGN_CENTER);
			document.add(head);

			Paragraph dt = new Paragraph("Date:  " + String.valueOf(rs.getDate("ord_date")));
			dt.setAlignment(Element.ALIGN_RIGHT);
			document.add(dt);
			document.add(new Paragraph(" "));

			document.add(image2);
			Paragraph po_no = new Paragraph("Purchase Order No.: " + rs.getString("po_no")+"               /CANCEL PURCHASE ORDER/");
			po_no.setAlignment(Element.ALIGN_LEFT);
			document.add(po_no);
			document.add(new Paragraph(" "));

			/*
			 * Paragraph to = new Paragraph("To: "); to.setAlignment(Element.ALIGN_LEFT);
			 * document.add(to);
			 */
			
			PdfPTable address;
			address = new PdfPTable(1);
			address.setTotalWidth(500);
			address.setLockedWidth(true);
			
			PdfPCell cella;
			cella = new PdfPCell(new Phrase("To: "));
			cella.setUseVariableBorders(true);
			cella.setBorderColorTop(BaseColor.WHITE);
			cella.setBorderColorBottom(BaseColor.WHITE);
			cella.setBorderColorLeft(BaseColor.WHITE);
			cella.setBorderColorRight(BaseColor.WHITE);
			address.addCell(cella);
			
			/*
			 * PdfPCell cellb; cellb = new PdfPCell(new Phrase("Thru: "));
			 * cellb.setUseVariableBorders(true); cellb.setBorderColorTop(BaseColor.WHITE);
			 * cellb.setBorderColorBottom(BaseColor.WHITE);
			 * cellb.setBorderColorLeft(BaseColor.WHITE);
			 * cellb.setBorderColorRight(BaseColor.WHITE); address.addCell(cellb);
			 */
			
			PdfPCell cellc;
			cellc = new PdfPCell(new Phrase(rs.getString("ord_vendor")));
			cellc.setUseVariableBorders(true);
			cellc.setBorderColorTop(BaseColor.WHITE);
			cellc.setBorderColorBottom(BaseColor.WHITE);
			cellc.setBorderColorLeft(BaseColor.WHITE);
			cellc.setBorderColorRight(BaseColor.WHITE);
			address.addCell(cellc);
			
			PdfPCell celld;
			celld = new PdfPCell(new Phrase(rs.getString("vendor_address")));
			celld.setUseVariableBorders(true);
			celld.setBorderColorTop(BaseColor.WHITE);
			celld.setBorderColorBottom(BaseColor.WHITE);
			celld.setBorderColorLeft(BaseColor.WHITE);
			celld.setBorderColorRight(BaseColor.WHITE);
			address.addCell(celld);
			
			/*
			 * PdfPCell celle; celle = new PdfPCell(new Phrase("Red Lakes Distributors,"));
			 * celle.setUseVariableBorders(true); celle.setBorderColorTop(BaseColor.WHITE);
			 * celle.setBorderColorBottom(BaseColor.WHITE);
			 * celle.setBorderColorLeft(BaseColor.WHITE);
			 * celle.setBorderColorRight(BaseColor.WHITE); address.addCell(celle);
			 * 
			 * PdfPCell cellf; cellf = new PdfPCell(new Phrase("24, Leicester Road,"));
			 * cellf.setUseVariableBorders(true); cellf.setBorderColorTop(BaseColor.WHITE);
			 * cellf.setBorderColorBottom(BaseColor.WHITE);
			 * cellf.setBorderColorLeft(BaseColor.WHITE);
			 * cellf.setBorderColorRight(BaseColor.WHITE); address.addCell(cellf);
			 * 
			 * PdfPCell cellg; cellg = new PdfPCell(new Phrase("10, Gandhi Road,"));
			 * cellg.setUseVariableBorders(true); cellg.setBorderColorTop(BaseColor.WHITE);
			 * cellg.setBorderColorBottom(BaseColor.WHITE);
			 * cellg.setBorderColorLeft(BaseColor.WHITE);
			 * cellg.setBorderColorRight(BaseColor.WHITE); address.addCell(cellg);
			 * 
			 * PdfPCell cellh; cellh = new PdfPCell(new
			 * Phrase("Fairfield, California(CA), 94534"));
			 * cellh.setUseVariableBorders(true); cellh.setBorderColorTop(BaseColor.WHITE);
			 * cellh.setBorderColorBottom(BaseColor.WHITE);
			 * cellh.setBorderColorLeft(BaseColor.WHITE);
			 * cellh.setBorderColorRight(BaseColor.WHITE); address.addCell(cellh);
			 * 
			 * PdfPCell celli; celli = new PdfPCell(new
			 * Phrase("JJ Nagar, New Delhi 600234")); celli.setUseVariableBorders(true);
			 * celli.setBorderColorTop(BaseColor.WHITE);
			 * celli.setBorderColorBottom(BaseColor.WHITE);
			 * celli.setBorderColorLeft(BaseColor.WHITE);
			 * celli.setBorderColorRight(BaseColor.WHITE); address.addCell(celli);
			 * 
			 * PdfPCell cellj; cellj = new PdfPCell(new Phrase(" "));
			 * cellj.setUseVariableBorders(true); cellj.setBorderColorTop(BaseColor.WHITE);
			 * cellj.setBorderColorBottom(BaseColor.WHITE);
			 * cellj.setBorderColorLeft(BaseColor.WHITE);
			 * cellj.setBorderColorRight(BaseColor.WHITE); address.addCell(cellj);
			 * 
			 * PdfPCell cellk; cellk = new PdfPCell(new Phrase(" "));
			 * cellk.setUseVariableBorders(true); cellk.setBorderColorTop(BaseColor.WHITE);
			 * cellk.setBorderColorBottom(BaseColor.WHITE);
			 * cellk.setBorderColorLeft(BaseColor.WHITE);
			 * cellk.setBorderColorRight(BaseColor.WHITE); address.addCell(cellk);
			 */
			document.add(address);
			
			/*
			 * address.addCell(new Phrase("To: ")); address.addCell(new Phrase("Thru: "));
			 * address.addCell(new Phrase(rs.getString("ord_vendor"))); address.addCell(new
			 * Phrase(rs.getString("ord_vendor"))); document.add(address);
			 */
			/*
			 * Paragraph ord_vendor = new Paragraph(rs.getString("ord_vendor") + ",\n\n\n");
			 * ord_vendor.setAlignment(Element.ALIGN_LEFT); document.add(ord_vendor);
			 */

			Paragraph subj = new Paragraph("Sirs," + "\n" + "                         Sub: Import of "
					+ rs_adddata.getString("item_name") + " etc.\n" + "                         Ref: Quotation No- "
					+ rs.getString("q_No") + " Validity Dated- " + String.valueOf(rs.getDate("q_validity") + "\n"));
			subj.setAlignment(Element.ALIGN_LEFT);
			document.add(subj);

			rs_adddata.beforeFirst();

			document.add(new Paragraph(" "));
			Paragraph intro = new Paragraph("With reference to the above you are kindly requested to"
					+ " cancel this respective order containing the following items as per the terms & Conditions eclosed.");
			intro.setAlignment(Element.ALIGN_LEFT);
			document.add(intro);

			/*
			 * Paragraph ord_vendor = new Paragraph(rs.getString("ord_vendor")+",");
			 * ord_vendor.setAlignment(Element.ALIGN_LEFT); document.add(ord_vendor);
			 */
			/*
			 * document.add(new Paragraph("PO Generated on : " + dtf.format(now)));
			 * System.out.println("part 4");
			 * 
			 * document.add(new Paragraph(" "));
			 */
			/* document.add(new Paragraph(" ")); */

			/*
			 * Paragraph v_details = new Paragraph("Vendor Details",
			 * FontFactory.getFont(FontFactory.HELVETICA_BOLD, 17, Font.BOLD,
			 * BaseColor.BLACK)); v_details.setAlignment(Element.ALIGN_LEFT);
			 * document.add(v_details);
			 * 
			 * document.add(new Paragraph(" ")); document.add(new Paragraph(" "));
			 * 
			 * PdfPTable table_vendor; table_vendor = new PdfPTable(2);
			 * 
			 * PdfPCell title_v_name = new PdfPCell(new Paragraph("Vendor Name:",
			 * FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD,
			 * BaseColor.BLACK))); table_vendor.addCell(title_v_name);
			 * 
			 * table_vendor.addCell(rs.getString("ord_vendor"));
			 * 
			 * PdfPCell title_v_add = new PdfPCell(new Paragraph("Vendor Address:",
			 * FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD,
			 * BaseColor.BLACK))); table_vendor.addCell(title_v_add);
			 * 
			 * table_vendor.addCell("13 Westside Road, Mumbai <default>");
			 * 
			 * document.add(table_vendor); document.add(new Paragraph(" "));
			 * 
			 * Paragraph p_details = new Paragraph("Order Details",
			 * FontFactory.getFont(FontFactory.HELVETICA_BOLD, 17, Font.BOLD,
			 * BaseColor.BLACK)); p_details.setAlignment(Element.ALIGN_LEFT);
			 * document.add(p_details);
			 * 
			 * document.add(new Paragraph(" ")); document.add(new Paragraph(" "));
			 * System.out.println("part 5"); PdfPTable table_basic; table_basic = new
			 * PdfPTable(2);
			 * 
			 * PdfPCell title1_basic = new PdfPCell(new Paragraph("PO Number:",
			 * FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD,
			 * BaseColor.BLACK))); table_basic.addCell(title1_basic);
			 * 
			 * table_basic.addCell(rs.getString("po_No"));
			 * 
			 * PdfPCell title2_basic = new PdfPCell(new Paragraph("Quotation Number:",
			 * FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD,
			 * BaseColor.BLACK))); table_basic.addCell(title2_basic);
			 * 
			 * table_basic.addCell(rs.getString("q_No")); System.out.println("part 6");
			 * PdfPCell title_qvd_basic = new PdfPCell(new Paragraph("Quotation Validity:",
			 * FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD,
			 * BaseColor.BLACK))); table_basic.addCell(title_qvd_basic);
			 * 
			 * table_basic.addCell(String.valueOf(rs.getDate("q_validity")));
			 */
			/*
			 * PdfPCell title3_basic = new PdfPCell(new
			 * Paragraph("Vendor Name:",FontFactory.getFont(FontFactory.HELVETICA_BOLD,11,
			 * Font.BOLD,BaseColor.BLACK))); table_basic.addCell(title3_basic);
			 * table_basic.addCell("Vendor Name:");
			 * table_basic.addCell(rs.getString("ord_vendor"));
			 */

			/*
			 * PdfPCell title4_basic = new PdfPCell(new Paragraph("Order Date:",
			 * FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD,
			 * BaseColor.BLACK))); table_basic.addCell(title4_basic);
			 * 
			 * table_basic.addCell(String.valueOf(rs.getDate("ord_date")));
			 * 
			 * document.add(table_basic);
			 * 
			 * document.add(new Paragraph(" ")); System.out.println("part 7"); Paragraph
			 * item_details = new Paragraph("Item Details",
			 * FontFactory.getFont(FontFactory.HELVETICA_BOLD, 17, Font.BOLD,
			 * BaseColor.BLACK)); item_details.setAlignment(Element.ALIGN_LEFT);
			 * document.add(item_details);
			 */

			/* document.add(new Paragraph(" ")); */
			document.add(new Paragraph(" "));
			int sno = 1;
			PdfPTable table_items;
			int i = 5;
			table_items = new PdfPTable(i);
			table_items.setTotalWidth(500);
			table_items.setLockedWidth(true);
			// table_items.setTotalWidth(100);
			// table_items.setWidths(new int[]{50, 150, 150, 150, 150});
			System.out.println("part 8");
			PdfPCell title1 = new PdfPCell(new Paragraph("S No.",
					FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD, BaseColor.BLACK)));
			PdfPCell title2 = new PdfPCell(new Paragraph("Item Name",
					FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD, BaseColor.BLACK)));
			PdfPCell title3 = new PdfPCell(new Paragraph("Quantity",
					FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD, BaseColor.BLACK)));
			/*
			 * PdfPCell title4 = new PdfPCell(new Paragraph("Unit",
			 * FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD,
			 * BaseColor.BLACK)));
			 */
			PdfPCell title4 = new PdfPCell(new Paragraph("Rate",
					FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD, BaseColor.BLACK)));
			PdfPCell title5 = new PdfPCell(new Paragraph("Cost",
					FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD, BaseColor.BLACK)));

			table_items.addCell(title1);
			table_items.addCell(title2);
			table_items.addCell(title3);
			table_items.addCell(title4);
			table_items.addCell(title5);
			/* table_items.addCell(title5); */

			while (rs_adddata.next()) {
				System.out.println("part repeated");
				
				PdfPCell cell; cell = new PdfPCell(new Phrase(String.valueOf(sno)+"."));
				cell.setUseVariableBorders(true); cell.setBorderColorTop(BaseColor.WHITE);
				cell.setBorderColorBottom(BaseColor.WHITE); table_items.addCell(cell);
				sno+=1;
				PdfPCell cell1;
				cell1 = new PdfPCell(new Phrase(rs_adddata.getString("item_name")));
				cell1.setUseVariableBorders(true);
				cell1.setBorderColorTop(BaseColor.WHITE);
				cell1.setBorderColorBottom(BaseColor.WHITE);
				table_items.addCell(cell1);

				PdfPCell cell2;
				cell2 = new PdfPCell(new Phrase(String.valueOf(rs_adddata.getFloat("quantity") + " " + rs_adddata.getString("unit"))));
				cell2.setUseVariableBorders(true);
				cell2.setBorderColorTop(BaseColor.WHITE);
				cell2.setBorderColorBottom(BaseColor.WHITE);
				table_items.addCell(cell2);
				
				PdfPCell cell3;
				cell3 = new PdfPCell(new Phrase(String.valueOf(rs_adddata.getFloat("rate"))));
				cell3.setUseVariableBorders(true);
				cell3.setBorderColorTop(BaseColor.WHITE);
				cell3.setBorderColorBottom(BaseColor.WHITE);
				table_items.addCell(cell3);
				
				String final_total = Float.toString(rs_adddata.getFloat("cost")) + " " +rs.getString("currency");
				
				PdfPCell cell4;
				cell4 = new PdfPCell(new Phrase(final_total));
				cell4.setUseVariableBorders(true);
				cell4.setBorderColorTop(BaseColor.WHITE);
				cell4.setBorderColorBottom(BaseColor.WHITE);
				table_items.addCell(cell4);
				
				/*
				 * PdfPCell cell; cell = new PdfPCell(new Phrase(String.valueOf(sno)));
				 * cell.setUseVariableBorders(true); cell.setBorderColorTop(BaseColor.WHITE);
				 * cell.setBorderColorBottom(BaseColor.WHITE); table_items.addCell(cell);
				 * 
				 * PdfPCell cell1; cell1 = new PdfPCell(new
				 * Phrase(rs_adddata.getString("item_name")));
				 * cell1.setUseVariableBorders(true); cell1.setBorderColorTop(BaseColor.WHITE);
				 * cell1.setBorderColorBottom(BaseColor.WHITE); table_items.addCell(cell1);
				 * 
				 * PdfPCell cell2; cell2 = new PdfPCell(new Phrase(rs_adddata
				 * .getString(String.valueOf(rs_adddata.getFloat("quantity") +
				 * rs_adddata.getString("unit"))))); cell2.setUseVariableBorders(true);
				 * cell2.setBorderColorTop(BaseColor.WHITE);
				 * cell2.setBorderColorBottom(BaseColor.WHITE); table_items.addCell(cell2);
				 * 
				 * PdfPCell cell3; cell3 = new PdfPCell(new
				 * Phrase(String.valueOf(rs_adddata.getFloat("rate"))));
				 * cell3.setUseVariableBorders(true); cell3.setBorderColorTop(BaseColor.WHITE);
				 * cell3.setBorderColorBottom(BaseColor.WHITE); table_items.addCell(cell3);
				 * 
				 * String final_total = Float.toString(rs_adddata.getFloat("cost")) + " " +
				 * rs.getString("currency");
				 * 
				 * PdfPCell cell4; cell4 = new PdfPCell(new Phrase(final_total));
				 * cell4.setUseVariableBorders(true); cell4.setBorderColorTop(BaseColor.WHITE);
				 * cell4.setBorderColorBottom(BaseColor.WHITE); table_items.addCell(cell4);
				 */
				/*
				 * table_items.addCell(String.valueOf(sno));
				 * table_items.addCell(rs_adddata.getString("item_name"));
				 */
				/*
				 * table_items.addCell(String.valueOf(rs_adddata.getFloat("quantity") +
				 * rs_adddata.getString("unit")));
				 * table_items.addCell(rs_adddata.getString("unit"));
				 * table_items.addCell(String.valueOf(rs_adddata.getFloat("rate")));
				 * 
				 * table_items.addCell(final_total);
				 */
				/* table_items.addCell(title1); */
				/* table_items.addCell(title2); */
				/* table_items.addCell(title3); */
				/*
				 * table_items.addCell(title4); table_items.addCell(title5);
				 */
			}

			PdfPCell emptycell;
			emptycell = new PdfPCell(new Phrase(" "));
			emptycell.setUseVariableBorders(true);
			emptycell.setBorderColorTop(BaseColor.WHITE);
			emptycell.setBorderColorBottom(BaseColor.WHITE);

			
			
			for (int k = 0; k < i * 7; k++) table_items.addCell(emptycell);
			 

			PdfPCell grand_total = new PdfPCell(new Paragraph("Grand Total:",
					FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD, BaseColor.BLACK)));
			table_items.addCell(grand_total);
			for (int k = 2; k < i; k++)
				table_items.addCell(" ");
			table_items.addCell(String.valueOf(rs.getFloat("grand_total")) + " " + rs.getString("currency"));
			System.out.println("part 9");
			/*
			 * for (int k = 0; k < i; k++) table_items.addCell(" ");
			 */
			
			
			
			
			 PdfPCell payment_type = new PdfPCell(new Paragraph("Payment Type:", //
			 FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD,
					 	BaseColor.BLACK)));
			 
			  table_items.addCell(payment_type);
			/*
			 * for (int k = 2; k < i; k++) table_items.addCell(" ");
			 */
			  
			  String payment_option = rs.getString("payment_type");
			  if(payment_option.equals("COD"))
				  payment_option="Cash on Delivery";
			  else if(payment_option.equals("LC"))
				  payment_option="Letter of Credit";
			  else if(payment_option.equals("ADV"))
				  payment_option="Advance Payment";
			  else if(payment_option.equals("NTD"))
				  payment_option="Net Thirty Days Payment";
			  
			  
			  PdfPCell payment_type_data = new PdfPCell(new Paragraph(payment_option));
			  payment_type_data.setColspan(4);
			  table_items.addCell(payment_type_data);
			/* table_items.addCell(rs.getString("payment_type")); */
			System.out.println("part 10");

			document.add(table_items);
			document.add(new Paragraph(" "));
			/*
			 * Paragraph payment = new Paragraph("Payment Details",
			 * FontFactory.getFont(FontFactory.HELVETICA_BOLD, 17, Font.BOLD,
			 * BaseColor.BLACK)); payment.setAlignment(Element.ALIGN_LEFT);
			 * document.add(payment);
			 * 
			 * document.add(new Paragraph(" ")); document.add(new Paragraph(" "));
			 * 
			 * PdfPTable table_payment; table_payment = new PdfPTable(2);
			 * 
			 * PdfPCell payment_option = new PdfPCell(new Paragraph("Payment Type:",
			 * FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD,
			 * BaseColor.BLACK))); table_payment.addCell(payment_option);
			 * table_basic.addCell("PO Number:");
			 * table_payment.addCell(rs.getString("payment_type"));
			 * 
			 * table_payment.addCell(" "); table_payment.addCell(" ");
			 * 
			 * PdfPCell payment_amount = new PdfPCell(new Paragraph("Paid Amount:",
			 * FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD,
			 * BaseColor.BLACK))); table_payment.addCell(payment_amount);
			 * table_basic.addCell("PO Number:");
			 * table_payment.addCell(rs.getString("payment_amount"));
			 * 
			 * PdfPCell payment_rem = new PdfPCell(new Paragraph("Payment Remaining:",
			 * FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Font.BOLD,
			 * BaseColor.BLACK))); table_payment.addCell(payment_rem);
			 * table_basic.addCell("PO Number:"); float pay_rem = rs.getFloat("grand_total")
			 * - rs.getFloat("payment_amount");
			 * table_payment.addCell(String.valueOf(pay_rem));
			 * 
			 * document.add(table_payment);
			 */
			document.newPage();
			document.add(new Paragraph(" "));
			Paragraph head2 = new Paragraph("Terms and Conditions",
					FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, Font.BOLD, BaseColor.BLACK));
			head2.setAlignment(Element.ALIGN_CENTER);
			document.add(head2);
			document.add(new Paragraph(" "));
			document.add(new Paragraph(" "));
			document.add(new Paragraph("" + 
					"You agree that by accessing the Site, you have read, understood, and agree to be bound by all of these Terms and Conditions. If you do not agree with all of these Terms and Conditions, then you are expressly prohibited from using the Site and you must discontinue use immediately.\r\n" + 
					"Supplemental terms and conditions or documents that may be posted on the Site from time to time are hereby expressly incorporated herein by reference. We reserve the right, in our sole discretion, to make changes or modifications to these Terms and Conditions at any time and for any reason.\r\n" + 
					"We will alert you about any changes by updating the “Last updated” date of these Terms and Conditions, and you waive any right to receive specific notice of each such change.\r\n" + 
					"It is your responsibility to periodically review these Terms and Conditions to stay informed of updates. You will be subject to, and will be deemed to have been made aware of and to have accepted, the changes in any revised Terms and Conditions by your continued use of the Site after the date such revised Terms and Conditions are posted.\r\n" + 
					"The information provided on the Site is not intended for distribution to or use by any person or entity in any jurisdiction or country where such distribution or use would be contrary to law or regulation or which would subject us to any registration requirement within such jurisdiction or country.\r\n" + 
					"Accordingly, those persons who choose to access the Site from other locations do so on their own initiative and are solely responsible for compliance with local laws, if and to the extent local laws are applicable.\r\n" + 
					"These terms and conditions were generated by Termly’s Terms and Conditions Generator.\r\n" + 
					"Option 1: The Site is intended for users who are at least 18 years old. Persons under the age of 18 are not permitted to register for the Site.\r\n" + 
					"Option 2: [The Site is intended for users who are at least 13 years of age.] All users who are minors in the jurisdiction in which they reside (generally under the age of 18) must have the permission of, and be directly supervised by, their parent or guardian to use the Site. If you are a minor, you must have your parent or guardian read and agree to these Terms and Conditions prior to you using the Site.\r\n" + 
					"INTELLECTUAL PROPERTY RIGHTS\r\n" + 
					"Unless otherwise indicated, the Site is our proprietary property and all source code, databases, functionality, software, website designs, audio, video, text, photographs, and graphics on the Site (collectively, the “Content”) and the trademarks, service marks, and logos contained therein (the “Marks”) are owned or controlled by us or licensed to us, and are protected by copyright and trademark laws and various other intellectual property rights and unfair competition laws of the United States, foreign jurisdictions, and international conventions.\r\n" + 
					"The Content and the Marks are provided on the Site “AS IS” for your information and personal use only."+ 
					"\r\n" + 
					""));
			document.close();
			/* document.add(new Paragraph(fn)); */
			// return document;
			/*
			 * document.close(); return document;
			 */

			System.out.println("part 11");

		} catch (Exception e) {
			e.printStackTrace();
		}
		/*
		 * Document dc = new Document(); return dc;
		 */
		System.out.println("part 12 almost exit");
		return "hello";
	}
}

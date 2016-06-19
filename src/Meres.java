import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.*;
import java.net.URL;
import javax.net.ssl.HttpsURLConnection;
import org.json.*;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

public class Meres {
	
	public static JSONObject talalat(String key, String cx, String q, int start)throws Exception{
				
				String httpsURL = "https://www.googleapis.com/customsearch/v1?key="+key+"&cx="+cx+"&q="+q+"&start="+start;

				URL myurl = new URL(httpsURL);
		    		HttpsURLConnection con = (HttpsURLConnection)myurl.openConnection();
		    		InputStream ins = con.getInputStream();
		    		InputStreamReader isr = new InputStreamReader(ins);
		    		BufferedReader in = new BufferedReader(isr);

		    		String inputLine;
		    		StringBuffer str = new StringBuffer ("");

		    		while ((inputLine = in.readLine()) != null)
		   		{
		    	
		    			str.append(inputLine);
					str.append("\n");
		    		}

		    		in.close();

				JSONObject jsObject= new JSONObject(new JSONTokener(str.toString()));
				return jsObject;
				
	}
	
	public static void historybaIr(Connection con, String kulcsszo, String oldalcim) throws Exception{

        Statement st1 = null;
        ResultSet rs1 = null;

        Statement st3 = null;
        ResultSet rs3 = null;

        Statement st7 = null;
        ResultSet rs7 = null;

        PreparedStatement pst4 = null;
        
		//smallest time diff.
        String date= "SELECT gyakorisag.gyakorisag, timediff(now(),datum) AS kul  FROM history JOIN gyakorisag ON history_id=gyakorisag.id WHERE kulcsszo= '" + kulcsszo + "' " + "ORDER BY kul";
        st1= con.createStatement();
        rs1= st1.executeQuery( date );
        
      //ha mar van history-ban
        if( rs1.next() && ( rs1.getLong(2) - rs1.getLong(1) >= 0 ) ){

            System.out.print( "legkisebbido: " + rs1.getLong(2) );

                  //kereses szora, kiirja, hogy hanyadik
                  for( int j= 1; j< 11; j+=10 ){

                	  String urlEncoded= java.net.URLEncoder.encode(kulcsszo, "UTF-8");
                	  
                      JSONObject jsObject= talalat( "AIzaSyBfBUnw-iBzS2zEQ9BZ7zYTQZifdolAbn8", "018311114786755375724:ha7fx2iwxsi", urlEncoded, j );
                      JSONArray jsObjectArray= jsObject.getJSONArray( "items" );
                      Thread.sleep(2000);
                      
                      for( int i=0; i< jsObjectArray.length(); i++ ){
                    	  JSONObject jsObjectObject= jsObjectArray.getJSONObject(i);
                    	  int utolso;
                    	  
                    	  st3 = con.createStatement();
                          rs3 = st3.executeQuery( "SELECT meresiEredmeny, tart_oldal, datum FROM history, gyakorisag WHERE history_id=gyakorisag.id AND kulcsszo= '" + kulcsszo + "' AND oldalcim= '" + oldalcim + "' AND tart_oldal='" + jsObjectObject.getString("link") + "' ORDER BY datum DESC" );
                          //ha mar van eredmeny
                          if ( rs3.next() ){
                        	  utolso= rs3.getInt(1);
                          }
                          else{
                        	  utolso= -1;
                          }

                          st7 = con.createStatement();
                          rs7 = st7.executeQuery( "SELECT id FROM gyakorisag WHERE kulcsszo= '" + kulcsszo + "' AND oldalcim= '" + oldalcim + "'" );
                          rs7.next();

                          if( jsObjectObject.getString("link").contains(oldalcim) ){
                        	  //ha nem volt eredmeny, akkor -1 a valtozas
                        	  if( utolso ==-1 ){
                        		  pst4 = con.prepareStatement( "INSERT INTO history(history_id, meresiEredmeny, tart_oldal, valtozas, datum) VALUES("+ rs7.getInt(1) + ", " + (j+i) + ",\"" + jsObjectObject.getString("link") + "\", " + utolso + ", now())" );
                        		  pst4.executeUpdate();
                        	  }
                        	  else{
                        		  pst4 = con.prepareStatement( "INSERT INTO history(history_id, meresiEredmeny, tart_oldal, valtozas, datum) VALUES("+ rs7.getInt(1) + ", " + (j+i) + ",\"" + jsObjectObject.getString("link") + "\", " + (utolso-(j+i)) + ", now())" );
                        		  pst4.executeUpdate();
                        	  }
                          }

                      }
                  }
        }
        //ha meg nincs history-ban
        else if ( rs1.isAfterLast() ){
            try{
                
                //API results to file
               //kereses szora, kiirja, hogy hanyadik
                for( int j= 1; j< 11; j+=10 ){

                	String urlEncoded= java.net.URLEncoder.encode(kulcsszo, "UTF-8");
                	
                    JSONObject jsObject= talalat( "AIzaSyBfBUnw-iBzS2zEQ9BZ7zYTQZifdolAbn8", "018311114786755375724:ha7fx2iwxsi", urlEncoded, j );
                    JSONArray jsObjectArray= jsObject.getJSONArray( "items" );

                    for( int i=0; i< jsObjectArray.length(); i++ ){
                        JSONObject jsObjectObject= jsObjectArray.getJSONObject(i);

                        st7 = con.createStatement();
                        rs7 = st7.executeQuery( "SELECT id FROM gyakorisag WHERE kulcsszo= '" + kulcsszo + "' AND oldalcim= '" + oldalcim + "'" );
                        rs7.next();

                        if( jsObjectObject.getString("link").contains(oldalcim) ){

                            pst4 = con.prepareStatement( "INSERT INTO history(history_id, meresiEredmeny, tart_oldal, valtozas, datum) VALUES("+ rs7.getInt(1) + ", " + (j+i) + ",\"" + jsObjectObject.getString("link") + "\", " + 0 +", now())" );
                            pst4.executeUpdate();

                        }

                    }
                }


            } catch( Exception e ){//Catch exception if any
                System.err.println( "Error: " + e.getMessage() );
                  e.printStackTrace();
            }
        }
    }

	public static void futtatas(Connection con) throws Exception{
		Statement st = null;
        ResultSet rs = null;
        
        Statement st1 = null;
        ResultSet rs1 = null;

        Statement st3 = null;
        ResultSet rs3 = null;

        Statement st7 = null;
        ResultSet rs7 = null;

        PreparedStatement pst4 = null;

        try {
            st = con.createStatement();
            rs = st.executeQuery( "SELECT kulcsszo, oldalcim FROM gyakorisag" );

            while( rs.next() ) {
            	historybaIr(con, rs.getString("kulcsszo"), rs.getString("oldalcim"));            
            }
        }catch( Exception e ){
            System.err.println( "Error: " + e.getMessage() );
            e.printStackTrace();
      }

	}
	
	public static void main(String[] args) throws Exception{
		Connection con= null;
		String url = "jdbc:mysql://localhost:3306/seo";
        String user = "root";
        String password = "kklz96**";

        try {
            con = DriverManager.getConnection( url, user, password );
        }catch( Exception e ){
            System.err.println( "Error: " + e.getMessage() );
            e.printStackTrace();
            System.exit(0);
        }
        
		futtatas(con);
		
		try {
			con.close();
		}catch( Exception e ){
            System.err.println( "Error: " + e.getMessage() );
            e.printStackTrace();
		}
		
	}
	
}

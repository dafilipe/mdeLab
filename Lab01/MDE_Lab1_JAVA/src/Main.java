import java.sql.*;
import java.util.Scanner;


public class Main {

    //Database information
        private static final String DB_URL = "jdbc:mysql://127.0.0.1/voltway_db?useSSL=false";    //Update if necessary
        private static final String DB_USERNAME = "root";                                                     //Replace with your database username
        private static final String DB_PASSWORD = "mde";                                                      //Replace with user password

        
        private static final Scanner scanner = new Scanner(System.in);
        private static Connection conn = null;


    public static void main(String[] args) throws SQLException {
        
        System.out.println("MDE Lab1 - Welcome to the Java Project");
                
        try {
            //Start DB Connection
            conn = MySQL_Integration.createConnection(DB_URL,DB_USERNAME,DB_PASSWORD);
            System.out.println("Connected to the database.");

            int rf_option;
            do{
                menu();
                rf_option = readOption();
                handleOption(conn, rf_option);
            } while (rf_option != 0);
            
        }catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    MySQL_Integration.closeConnection(conn);
                    System.out.println("Ligação encerrada com sucesso.");
                } catch (SQLException e) {
                    System.out.println("Erro ao fechar a ligação: " + e.getMessage());
                }
            }
            scanner.close();
        }           
    }

    // ****************************** MENU METHODS ********************************
    private static void menu(){
        System.out.println("\n===== MENU PRINCIPAL =====");
        System.out.println("1 - (RF1) Visualizar histórico de....");
        System.out.println("2 - (RF2) Visualizar todas as sessoes....");
        // fill in with all requirements
    }

    public static int readOption() {
        while (!scanner.hasNextInt()) {
            System.out.print("Opcao invalida. Introduza um numero: ");
            scanner.next();
        }
        int option = scanner.nextInt();
        scanner.nextLine(); // limpar buffer
        return option;
    }

    public static void handleOption(Connection conn, int option) {
        try {
            switch (option) {
                case 1:
                    viewSessionHistoryByUser(conn);
                    break;
                case 2:
                    viewAllSessionsByChargingStation(conn);
                    break;
                // fill in with the remaining requirements
                
                
                case 0:
                    System.out.println("A terminar o programa...");
                    break;
                default:
                    System.out.println("Opcao invalida.");
            }
        } catch (SQLException e) {
            System.out.println("Erro ao executar a operacao: " + e.getMessage());
        }
    }
   
    // ***************************  Requirements Methods *******************************

    public static void viewSessionHistoryByUser(Connection conn) throws SQLException {
       // to implement
    }

    public static void viewAllSessionsByChargingStation(Connection conn) throws SQLException {
        System.out.print("Introduza o id do posto de carregamento: ");
        String idChargingPost = scanner.nextLine();
       
       
        String query = "SELECT * FROM charging_session WHERE Charging_Station_idCharging_station = '" + idChargingPost + "'";
        ResultSet rs = MySQL_Integration.executeQuery(conn, query);

        ResultSetMetaData metaData = rs.getMetaData();   //gets info about the columns
        int columnCount = metaData.getColumnCount();     //gets the number of columns

        System.out.println("\n--- Sessoes Realizadas ---");
        
        // Header
        for (int i = 1; i <= columnCount; i++) {
            System.out.printf("%-25s", metaData.getColumnName(i) + "\t");
        }
        System.out.println();

        // List the corresponding elements 
        while (rs.next()) {
            for (int i = 1; i <= columnCount; i++) {
                System.out.printf("%-25s", rs.getString(i) + "\t");
            }
            System.out.println();            
        }
        rs.close();
    }

    // implement the remaining requirements methods
}
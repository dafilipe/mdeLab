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
        System.out.println("1 - (RF1) Visualizar histórico de sessões de um user.");
        System.out.println("2 - (RF2) Visualizar todas as sessoes de um posto.");
        System.out.println("3 - (RF3) Visualizar todas as sessoes de carregamento.");
        System.out.println("4 - (RF4) Visualizar Carregadores mais usados.");
        System.out.println("5 - (RF5) Visualizar Consumo dos users.");
        System.out.println("6 - (RF6) Visualizar medicoes dos sensores.");
        System.out.println("10- (RF10) Visualizar Tecnicos de uma cidade.");
        System.out.println("11- (RF11) Visualizar numero de Tecnicos por cidade.");
        System.out.println("");
        System.out.println("0 - Sair.");
        System.out.println("");
        System.out.print("> ");
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
                case 3:
                    viewAllChargingSessions(conn);
                    break;
                case 4:
                    viewMostUsedChargers(conn);
                    break;
                case 5:
                    viewBiggestConsumers(conn);
                    break;
                case 6:
                    viewSensorMeas(conn);
                    break;
                case 10:
                    viewTechniciansInCity(conn);
                    break;
                case 11:
                    viewTechniciansNumPerCity(conn);
                    break;
                
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
        System.out.print("Introduza o nome do utilizador: ");
        String userName = scanner.nextLine();
        System.out.print("Introduza a data de inicio (YYYY-MM-DD): ");
        String dataInicio = scanner.nextLine();
        System.out.print("Introduza a data de Fim (YYYY-MM-DD): ");
        String dataFim = scanner.nextLine();

        String query = "SELECT "+
                            "plate AS Matricula, "+
                            "entry_time AS Inicio, "+
                            "fin_time AS Fim, "+
                            "cons_energy AS Energia, "+
                            "id_charger AS ID_Carregador "+
                        "FROM "+
                            "charging_session "+
                        "WHERE "+
                            "plate IN ( "+
                                "SELECT plate "+
                                "FROM car "+
                                "WHERE id_user = ( "+
                                    "SELECT id_user "+
                                    "FROM user "+
                                    "WHERE name = '"+ userName +"' "+
                                ") "+
                            ") "+
                            "AND entry_time BETWEEN '"+ dataInicio +" 00:00:00' AND '"+ dataFim +" 23:59:59' "+
                        "ORDER BY "+
                        "entry_time DESC";
        ResultSet rs = MySQL_Integration.executeQuery(conn, query);

        ResultSetMetaData metaData = rs.getMetaData();   //gets info about the columns
        int columnCount = metaData.getColumnCount();     //gets the number of columns

        System.out.println("\n--- Sessoes Realizadas ---");
        
        // Header
        for (int i = 1; i <= columnCount; i++) {
            System.out.printf("%-25s", metaData.getColumnLabel(i));
        }
        System.out.println();
        System.out.println();

        while (rs.next()) {
            for (int i = 1; i <= columnCount; i++) {
                String value = rs.getString(i);
                System.out.printf("%-25s", value == null ? "null" : value);
            }
            System.out.println();
        }
        rs.close();
    }

    public static void viewAllSessionsByChargingStation(Connection conn) throws SQLException {
        System.out.print("Introduza o id da estação: ");
        String idStation = scanner.nextLine();
       
       
        String query = "SELECT " +
                            "id_session AS sessao, " +
                            "plate AS Matricula, " +
                            "entry_time AS Inicio, " +
                            "fin_time AS Fim, " +
                            "cons_energy AS Energia, " +
                            "id_charger AS Carregador " +
                        "FROM " +
                            "charging_session " +
                        "WHERE " +
                            "id_charger IN ( " +
                                "SELECT id_charger " +
                                "FROM charger " +
                                "WHERE id_station = "+ idStation +" " +
                            ") " +
                        "ORDER BY " +
                            "entry_time DESC";
        ResultSet rs = MySQL_Integration.executeQuery(conn, query);

        ResultSetMetaData metaData = rs.getMetaData();   //gets info about the columns
        int columnCount = metaData.getColumnCount();     //gets the number of columns

        System.out.println("\n--- Sessoes Realizadas ---");
        
        // Header
        for (int i = 1; i <= columnCount; i++) {
            System.out.printf("%-25s", metaData.getColumnLabel(i));
        }
        System.out.println();
        System.out.println();

        while (rs.next()) {
            for (int i = 1; i <= columnCount; i++) {
                String value = rs.getString(i);
                System.out.printf("%-25s", value == null ? "null" : value);
            }
            System.out.println();
        }
        rs.close();
    }

    public static void viewAllChargingSessions(Connection conn) throws SQLException {      
        String query = "SELECT " +
                                "u.name AS 'Nome User', " +
                                "c.plate AS 'Matricula', " +
                                "c.brand AS 'Marca', " +
                                "c.model AS 'Modelo', " +
                                "s.city AS 'Localização Posto', " +
                                "s.address AS 'Morada', " +
                                "cs.entry_time AS 'Início Sessão', " +
                                "cs.fin_time AS 'Fim Sessão', " +
                                "cs.cons_energy AS 'Energia' " +
                        "FROM " +
                                "charging_session cs " +
                        "JOIN " +
                                "car c ON cs.plate = c.plate " +
                        "JOIN " +
                                "user u ON c.id_user = u.id_user " +
                        "JOIN " +
                                "charger chr ON cs.id_charger = chr.id_charger " +
                        "JOIN " +
                                "station s ON chr.id_station = s.id_station " +
                        "ORDER BY " +
                                "cs.entry_time DESC";
        ResultSet rs = MySQL_Integration.executeQuery(conn, query);

        ResultSetMetaData metaData = rs.getMetaData();   //gets info about the columns
        int columnCount = metaData.getColumnCount();     //gets the number of columns

        System.out.println("\n--- Todas as sessoes de carregamento ---");
        
        // Header
        for (int i = 1; i <= columnCount; i++) {
            System.out.printf("%-20s", metaData.getColumnLabel(i));
        }
        System.out.println();
        System.out.println();

        while (rs.next()) {
            for (int i = 1; i <= columnCount; i++) {
                String value = rs.getString(i);
                System.out.printf("%-20s", value == null ? "null" : value);
            }
            System.out.println();
        }
        rs.close();
    }

    public static void viewMostUsedChargers(Connection conn) throws SQLException {
        System.out.print("Introduza a data de inicio (YYYY-MM-DD): ");
        String dataInicio = scanner.nextLine();
        System.out.print("Introduza a data de Fim (YYYY-MM-DD): ");
        String dataFim = scanner.nextLine();

        String query = "SELECT " +
                                "c.id_charger AS Carregador, " +
                                "c.id_station AS Estacao, " +
                                "s.city AS Cidade, " +
                                "s.address AS Morada, " +
                                "COUNT(cs.id_session) AS total_sessions " +
                        "FROM charging_session cs " +
                        "JOIN charger c " +
                                "ON cs.id_charger = c.id_charger " +
                        "JOIN station s " +
                                "ON c.id_station = s.id_station " +
                        "WHERE cs.entry_time BETWEEN '"+ dataInicio +" 00:00:00' AND '"+ dataFim +" 23:59:59' " +
                        "GROUP BY c.id_charger, c.id_station, s.city, s.address " +
                        "ORDER BY total_sessions DESC";
        ResultSet rs = MySQL_Integration.executeQuery(conn, query);

        ResultSetMetaData metaData = rs.getMetaData();   //gets info about the columns
        int columnCount = metaData.getColumnCount();     //gets the number of columns

        System.out.println("\n--- Carregadores mais usados ---");
        
        // Header
        for (int i = 1; i <= columnCount; i++) {
            System.out.printf("%-25s", metaData.getColumnLabel(i));
        }
        System.out.println();
        System.out.println();

        while (rs.next()) {
            for (int i = 1; i <= columnCount; i++) {
                String value = rs.getString(i);
                System.out.printf("%-25s", value == null ? "null" : value);
            }
            System.out.println();
        }
        rs.close();
    }

    public static void viewBiggestConsumers(Connection conn) throws SQLException {
        String query = "SELECT " +
                                "u.id_user AS Utilizador, " +
                                "u.name AS Nome, " +
                                "u.email AS Email, " +
                                "SUM(cs.cons_energy) AS total_consumed_energy " +
                        "FROM user u " +
                        "JOIN car c " +
                                "ON u.id_user = c.id_user " +
                        "JOIN charging_session cs " +
                                "ON c.plate = cs.plate " +
                        "GROUP BY u.id_user, u.name, u.email " +
                        "ORDER BY total_consumed_energy DESC";
        ResultSet rs = MySQL_Integration.executeQuery(conn, query);

        ResultSetMetaData metaData = rs.getMetaData();   //gets info about the columns
        int columnCount = metaData.getColumnCount();     //gets the number of columns

        System.out.println("\n--- Consumo dos utilizadores ---");
        
        // Header
        for (int i = 1; i <= columnCount; i++) {
            System.out.printf("%-25s", metaData.getColumnLabel(i));
        }
        System.out.println();
        System.out.println();

        while (rs.next()) {
            for (int i = 1; i <= columnCount; i++) {
                String value = rs.getString(i);
                System.out.printf("%-25s", value == null ? "null" : value);
            }
            System.out.println();
        }
        rs.close();
    }

    public static void viewSensorMeas(Connection conn) throws SQLException {
        String query = "SELECT * FROM view_sensor_meas1";
        ResultSet rs = MySQL_Integration.executeQuery(conn, query);

        ResultSetMetaData metaData = rs.getMetaData();   //gets info about the columns
        int columnCount = metaData.getColumnCount();     //gets the number of columns

        System.out.println("\n--- Medicoes dos sensores ---");
        
        // Header
        for (int i = 1; i <= columnCount; i++) {
            System.out.printf("%-25s", metaData.getColumnLabel(i));
        }
        System.out.println();
        System.out.println();

        while (rs.next()) {
            for (int i = 1; i <= columnCount; i++) {
                String value = rs.getString(i);
                System.out.printf("%-25s", value == null ? "null" : value);
            }
            System.out.println();
        }
        rs.close();
    }

    public static void viewTechniciansInCity(Connection conn) throws SQLException {
        System.out.print("Introduza o nome da cidade: ");
        String city = scanner.nextLine();

        String query = "select id_tecnico AS Tecnico, nome AS Nome, telefone AS Telefone, email AS Email, local_area AS Area, estado AS Estado, posto_atribuido AS 'Carregador Atribuido' FROM tecnicalDepartment where local_area = \""+ city +"\"";
        ResultSet rs = MySQL_Integration.executeQuery(conn, query);

        ResultSetMetaData metaData = rs.getMetaData();   //gets info about the columns
        int columnCount = metaData.getColumnCount();     //gets the number of columns

        System.out.println("\n--- Tecnicos de "+ city +" ---");
        
        // Header
        for (int i = 1; i <= columnCount; i++) {
            System.out.printf("%-25s", metaData.getColumnLabel(i));
        }
        System.out.println();
        System.out.println();

        while (rs.next()) {
            for (int i = 1; i <= columnCount; i++) {
                String value = rs.getString(i);
                System.out.printf("%-25s", value == null ? "null" : value);
            }
            System.out.println();
        }
        rs.close();
    }

    public static void viewTechniciansNumPerCity(Connection conn) throws SQLException {
        String query = "SELECT " +
                    "local_area AS Cidade, " +
                    "COUNT(*) AS Tecnicos " +
               "FROM tecnicalDepartment " +
               "GROUP BY local_area " +
               "ORDER BY Tecnicos DESC";
        ResultSet rs = MySQL_Integration.executeQuery(conn, query);

        ResultSetMetaData metaData = rs.getMetaData();   //gets info about the columns
        int columnCount = metaData.getColumnCount();     //gets the number of columns

        System.out.println("\n--- Tecnicos Por Cidade ---");
        
        // Header
        for (int i = 1; i <= columnCount; i++) {
            System.out.printf("%-25s", metaData.getColumnLabel(i));
        }
        System.out.println();
        System.out.println();

        while (rs.next()) {
            for (int i = 1; i <= columnCount; i++) {
                String value = rs.getString(i);
                System.out.printf("%-25s", value == null ? "null" : value);
            }
            System.out.println();
        }
        rs.close();
    }

    // implement the remaining requirements methods
}
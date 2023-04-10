package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Grupos;

public class GruposDAO implements IGruposDAO<Grupos>{
	
	private GenericDAO gDao;
	
	public GruposDAO(GenericDAO gDao) {
		this.gDao = gDao;
	}
	
	private String execDividirTimesEspeciais() throws SQLException, ClassNotFoundException{
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_divide_times_excluidos}";
		CallableStatement cs = c.prepareCall(sql);
		cs.execute();
		
		String saida = cs.getString(0);
		
		cs.close();
		c.close();
		return saida;
		
	}
	
	private String execDividirTimes() throws SQLException, ClassNotFoundException{
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_divide_times_em_grupos}";
		CallableStatement cs = c.prepareCall(sql);
		cs.execute();
		
		String saida = cs.getString(0);
		
		cs.close();
		c.close();
		return saida;
		
	}

	@Override
	public List<Grupos> grupoA() throws SQLException, ClassNotFoundException {
		List<Grupos> grupoA = new ArrayList<>();
		Connection c = gDao.getConnection();
		
		String sql = "SELECT t.nome_time, g.grupo\r\n"+
					 "FROM grupos g, times t\r\n"+
					 "WHERE t.cod_time = g.cod_time AND grupo = 'A'";
		
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()){
			Grupos ga = new Grupos();
			ga.setNome_time(rs.getString("nome_time"));
			ga.setGrupo(rs.getString("grupo"));
			
			grupoA.add(ga);
		}
		rs.close();
		ps.close();
		c.close();
		return grupoA;
	}

	@Override
	public List<Grupos> grupoB() throws SQLException, ClassNotFoundException {
		List<Grupos> grupoB = new ArrayList<>();
		Connection c = gDao.getConnection();
		
		String sql = "SELECT t.nome_time, g.grupo\r\n"+
					 "FROM grupos g, times t\r\n"+
					 "WHERE t.cod_time = g.cod_time AND grupo = 'A'";
		
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()){
			Grupos gb = new Grupos();
			gb.setNome_time(rs.getString("nome_time"));
			gb.setGrupo(rs.getString("grupo"));
			
			grupoB.add(gb);
		}
		rs.close();
		ps.close();
		c.close();
		return grupoB;
	}

	@Override
	public List<Grupos> grupoC() throws SQLException, ClassNotFoundException {
		List<Grupos> grupoC = new ArrayList<>();
		Connection c = gDao.getConnection();
		
		String sql = "SELECT t.nome_time, g.grupo\r\n"+
					 "FROM grupos g, times t\r\n"+
					 "WHERE t.cod_time = g.cod_time AND grupo = 'A'";
		
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()){
			Grupos gc = new Grupos();
			gc.setNome_time(rs.getString("nome_time"));
			gc.setGrupo(rs.getString("grupo"));
			
			grupoC.add(gc);
		}
		rs.close();
		ps.close();
		c.close();
		return grupoC;
	}

	@Override
	public List<Grupos> grupoD() throws SQLException, ClassNotFoundException {
		List<Grupos> grupoD = new ArrayList<>();
		Connection c = gDao.getConnection();
		
		String sql = "SELECT t.nome_time, g.grupo\r\n"+
					 "FROM grupos g, times t\r\n"+
					 "WHERE t.cod_time = g.cod_time AND grupo = 'A'";
		
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()){
			Grupos gd = new Grupos();
			gd.setNome_time(rs.getString("nome_time"));
			gd.setGrupo(rs.getString("grupo"));
			
			grupoD.add(gd);
		}
		rs.close();
		ps.close();
		c.close();
		return grupoD;
	}

}

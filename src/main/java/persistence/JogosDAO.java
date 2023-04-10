package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import model.Jogos;

public class JogosDAO implements IJogosDAO<Jogos>{
	private GenericDAO gDao;
	
	public JogosDAO(GenericDAO gDao) {
		this.gDao = gDao;
	}
	
	private String execGerarRodadas() throws SQLException, ClassNotFoundException{
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_gerar_rodadas}";
		CallableStatement cs = c.prepareCall(sql);
		cs.execute();
		
		String saida = cs.getString(0);
		
		cs.close();
		c.close();
		return saida;
	}
	
	@Override
	public List<Jogos> listarJogos() throws SQLException, ClassNotFoundException {
		List<Jogos> jogos = new ArrayList<>();
		
		Connection c = gDao.getConnection();
		
		String sql = "SELECT ta.nome_time AS TimeA, j.gols_timeA, tb.nome_time AS TimeB, j.gols_timeB, j.data_rodada\r\n"+
					 "FROM jogos j, times ta, times tb\r\n"+
					 "WHERE ta.cod_time = j.cod_timeA AND tb.cod_time = j.cod_timeB";
		
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Jogos jogo = new Jogos();
			jogo.setNome_timeA(rs.getString("TimeA"));
			jogo.setGols_timeA(rs.getInt("gols_timeA"));
			jogo.setNome_timeB(rs.getString("TimeB"));
			jogo.setGols_timeB(rs.getInt("gols_timeB"));
			jogo.setData_jogo(LocalDate.parse(rs.getString("data_rodada")));
			
			jogos.add(jogo);
		}
		rs.close();
		ps.close();
		c.close();
		return jogos;
	}

	@Override
	public List<Jogos> buscarJogos(String data_jogo) throws SQLException, ClassNotFoundException {
		List<Jogos> jogos = new ArrayList<>();
		
		Connection c = gDao.getConnection();
		
		String sql = "SELECT ta.nome_time AS TimeA, j.gols_timeA, tb.nome_time AS TimeB, j.gols_timeB, j.data_rodada\r\n"+
					 "FROM jogos j, times ta, times tb\r\n"+
					 "WHERE ta.cod_time = j.cod_timeA AND tb.cod_time = j.cod_timeB AND data_rodada= ?";
		
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, data_jogo);
		
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Jogos jogo = new Jogos();
			jogo.setNome_timeA(rs.getString("TimeA"));
			jogo.setGols_timeA(rs.getInt("gols_timeA"));
			jogo.setNome_timeB(rs.getString("TimeB"));
			jogo.setGols_timeB(rs.getInt("gols_timeB"));
			jogo.setData_jogo(LocalDate.parse(rs.getString("data_rodada")));
			
			jogos.add(jogo);
		}
		rs.close();
		ps.close();
		c.close();
		return jogos;
	}
	
}

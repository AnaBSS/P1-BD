package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Times;

public class TimesDAO implements ITimesDAO<Times>{
    private GenericDAO gDao;

    public TimesDAO(GenericDAO gDao) {
        this.gDao = gDao;
    }

    @Override
    public List<Times> list() throws SQLException, ClassNotFoundException {
        List<Times> times = new ArrayList<>();

        Connection c = gDao.getConnection();
        String sql = "SELECT cod_time, nome_time, cidade, estadio, material_esportivo FROM times ORDER BY nome_time";
        PreparedStatement ps = c.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while(rs.next()) {
            Times time = new Times();
            time.setCod_time(rs.getInt("cod_time"));
            time.setNome(rs.getString("nome_time"));
            time.setCidade(rs.getString("cidade"));
            time.setEstadio(rs.getString("estadio"));
            time.setMaterial_esportivo(rs.getString("material_esportivo"));

            times.add(time);
        }
        rs.close();
        ps.close();
        c.close();
        return times;
    }
}
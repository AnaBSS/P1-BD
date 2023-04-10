package persistence;

import java.sql.SQLException;
import java.util.List;

public interface IGruposDAO<G> {
	public List<G> grupoA() throws SQLException, ClassNotFoundException;
	public List<G> grupoB() throws SQLException, ClassNotFoundException;
	public List<G> grupoC() throws SQLException, ClassNotFoundException;
	public List<G> grupoD() throws SQLException, ClassNotFoundException;
}

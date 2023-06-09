package persistence;

import java.sql.SQLException;
import java.util.List;

public interface ITimesDAO<T> {
    public List<T> list() throws SQLException, ClassNotFoundException;
}
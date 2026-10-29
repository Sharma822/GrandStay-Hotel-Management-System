package com.hotel.dao;

import com.hotel.entity.Booking;
import com.hotel.entity.Customer;
import com.hotel.entity.Room;
import com.hotel.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.sql.Date;
import java.util.List;

public class HotelDAO {

    // --- Room Methods ---
    public void saveRoom(Room room) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.save(room);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    public List<Room> getAllRooms() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("from Room", Room.class).list();
        }
    }

    public List<Room> getAvailableRooms() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("from Room where status = 'AVAILABLE'", Room.class).list();
        }
    }

    // Ye method missing tha jiski wajah se error aa raha tha
    public Room getRoomById(int roomId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Room.class, roomId);
        }
    }

    // --- Customer Methods ---
    public void saveCustomer(Customer customer) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.save(customer);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    public Customer getCustomerByEmail(String email) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Customer> q = session.createQuery("from Customer where email = :email", Customer.class);
            q.setParameter("email", email);
            return q.uniqueResult();
        }
    }

    // --- Booking Methods ---
    public boolean bookRoom(int customerId, int roomId, Date checkIn, Date checkOut) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            Customer customer = session.get(Customer.class, customerId);
            Room room = session.get(Room.class, roomId);

            if (room != null && "AVAILABLE".equalsIgnoreCase(room.getStatus())) {
                Booking booking = new Booking(customer, room, checkIn, checkOut);
                room.setStatus("BOOKED");
                session.save(booking);
                session.update(room);
                tx.commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        }
    }

    public List<Booking> getAllBookings() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("select b from Booking b join fetch b.customer join fetch b.room", Booking.class).list();
        }
    }

    public void cancelBooking(int bookingId) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            Booking booking = session.get(Booking.class, bookingId);
            if (booking != null) {
                Room room = booking.getRoom();
                if (room != null) {
                    room.setStatus("AVAILABLE");
                    session.update(room);
                }
                session.delete(booking);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }
}
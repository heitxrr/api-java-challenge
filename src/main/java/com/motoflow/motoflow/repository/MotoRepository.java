package com.motoflow.motoflow.repository;

import com.motoflow.motoflow.model.Moto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

@Repository
public interface MotoRepository extends JpaRepository<Moto, Long> {
	@Query("""
		SELECT m FROM Moto m
		WHERE m.id IN (
			SELECT mov.moto.id FROM Movimentacao mov
			WHERE mov.setor.id = :idSetor
			AND mov.dataMovimentacao = (
				SELECT MAX(mv.dataMovimentacao) FROM Movimentacao mv WHERE mv.moto.id = mov.moto.id
			)
		)
	""")
	List<Moto> findMotosBySetor(@Param("idSetor") Long idSetor);
	Moto findByPlaca(String placa);
}

class Universidad{
    var donaciones = 0
    const property provincia
    var property honorarioRecomendado

    method donar(unaCantidad){
        donaciones += unaCantidad
    }
}

class ProfesionalVinculado{
    const property universidad
    var property honorario = universidad.honorarioRecomendado()
    var property provinciasQueTrabaja = #{universidad.provincia()}
    
    method cobrar(unImporte){

        universidad.donar(unImporte/2)
    }
}

class ProfesionalAsociado{
    const property universidad      
    const property provinciasQueTrabaja = #{"Entre Rios", "Santa Fe", "Corrientes"}
    const property honorario = 3000

    method cobrar(unImporte){
        asociacion.donar(unImporte)
    }
}

object asociacion{
    var totalRecaudado = 0

    method donar(unaCantidad){
        totalRecaudado += unaCantidad
    }
}

class ProfesionalLibre{
    var property provinciasQueTrabaja
    const property universidad
    const property honorario

    var totalRecaudado = 0

    method cobrar(unImporte){
        totalRecaudado += unImporte
    }

    method pasarDinero(unProfesional, unImporte){
        unProfesional.cobrar(unImporte)
        totalRecaudado -= unImporte
    }
}

class Empresa{
    const property contratados = #{}
    const property honorarioReferencia
    const property clientes = #{}

    method contratar(profesional){
        contratados.add(profesional)
    }
    method contratarTodos(listaProfesionales){
        contratados.addAll(listaProfesionales)
    }

    method despedir(profesional){
        contratados.remove(profesional)
    }

    method cuantosEstudiaronEn(unaUniversidad) = contratados.filter({pro => pro.universidad() == unaUniversidad}).size()
    

    method profesionalesCaros() = contratados.filter({pro => pro.honorario() > honorarioReferencia}).asSet()

    method universidadesFormadoras() = contratados.map({pro => pro.universidad()}).asSet()

    method profesionalMasBarato() = contratados.min({pro => pro.honorario()})

    method esDeGenteAcotada() = contratados.all({pro => pro.provinciasQueTrabaja().size() <= 3}) 

    method puedeSatisfacer(unSolicitante) = contratados.any({contratado => unSolicitante.puedeSerAtendida(contratado) })

    method darServicio(unSolicitante){
        if(self.puedeSatisfacer(unSolicitante)){
            const profesionalQueAtiende = contratados.find({contratado => unSolicitante.puedeSerAtendida(contratado)})
            profesionalQueAtiende.cobrar(profesionalQueAtiende.honorario())
            clientes.add(unSolicitante)
        }
    }

    method clientesQueTiene() = clientes.size()
    method tieneCliente(unCliente) = clientes.contains(unCliente)

    method tieneAlguienMasBaratoPara(unaProvincia, unProfesional) = contratados.any({
        otro => otro != unProfesional and otro.provinciasQueTrabaja().contains(unaProvincia) and otro.honorario() < unProfesional.honorario()})
    method esPocoAtractivo(unProfesional) = unProfesional.provinciasQueTrabaja().all({provincia => self.tieneAlguienMasBaratoPara(provincia, unProfesional) })

    
}
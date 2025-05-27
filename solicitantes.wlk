import profesionales.*
class SolicitantePersona{
    var property provincia

    method puedeSerAtendida(unProfesional) = unProfesional.provinciasQueTrabaja().contains(provincia)
}

class SolicitanteInstitucion{
    const property universidades //lista de universidades

    method puedeSerAtendida(unProfesional) = universidades.contains(unProfesional.universidad())

}

class SolicitanteClub{
    const property provincias //lista de provincias

    method puedeSerAtendida(unProfesional) = provincias.any({provincia => unProfesional.provincia().contains(provincia)})

}


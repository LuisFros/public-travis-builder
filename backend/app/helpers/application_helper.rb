module ApplicationHelper
  def get_jwks
    jwks = {"keys":[{"alg":"RS256","e":"AQAB","kid":"HzVQzAiYfW2gd+i7Zy+vQAmFPvMoA7vdYReeDkggCCs=","kty":"RSA","n":"3uNtD3grPDFBTjUc9WhJKcEaVQefVl7lmN6c7j1c3nRxQI6roXplxgek6o5Bohna19Ru6a-kvHGy1hJiqDWwgqLX05oYkKZQUqVom7d7n1qvcnkmLWVyJU3vzehkLcEyexgmOc_KXKnD6M0SOQhkwZ7l-1mStDUSPU-RjK39ZjFM5IrXTRBNsHNtr9_u9ee8PLkUMqYlnOTS6acQNZ4JShTeqKjfWTF19VJKBco50Q_4wB0uhf4U2Lna_RDstTnHoOdR3EGR3XpfTojlE2y8hY73OeUz7otEoN7a2TOxA_XxsgFVDCCMtuWDykUXLldaiBdYuls5kGrwhW39vyPukQ","use":"sig"},{"alg":"RS256","e":"AQAB","kid":"QeFPcYykhlDAnT8VRCVxYS7sEyG0/KUg8uVotHlDCQU=","kty":"RSA","n":"4H-ixC57k7tFNitWV6ZKbo_Lq-2X3ZtDC9Jc0LbeZCjNE2MsYflkDfWMG4Af7HpPY3phK8OSULim4eCqTCHhykfWI3GXv3QPxuMStd7Tu4KRALe-wu7WoGa_pyF7dMoo3GEaEZLUGlW6qcyrNLOCVkG7skOetfv7NbKMRFrwSJhqZ6Sh2Eg10ZwRDle1Ls91pPnz1o--Dy-We8ZjVF4kMMQVpAv_8jFzEAj5QWTSvbbN4SmVfI9tMAGmL3nXaE1tq_piZNP8p2IS-uc6EWbWCQjio1RL-m2nx-YXALj5JfRlMcNpSM52CNPguePCqbXeUTyDGr1WoGou6jMZ-oa8XQ","use":"sig"}]}
    return jwks
  end
end

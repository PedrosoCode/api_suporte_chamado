const jwt = require("jsonwebtoken");

const validaTokenSocket = (socket, next) => {
  try {
    const token = socket.handshake.auth.token; 

    if (!token) {
      return next(new Error("Token não fornecido."));
    }

    const tokenLimpo = token.replace("Bearer ", "");
    const jwtInfo = jwt.verify(tokenLimpo, process.env.JWT_SECRET);

    if (!jwtInfo?.jwt_nCodigoEmpresa) {
      return next(new Error("Token inválido ou expirado."));
    }

    socket.jwtInfo = jwtInfo;
    next();
  } catch (error) {
    return next(new Error("Token inválido ou expirado."));
  }
};

module.exports = {
  validaTokenSocket
};
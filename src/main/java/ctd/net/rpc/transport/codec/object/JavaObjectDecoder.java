package ctd.net.rpc.transport.codec.object;


import java.io.InputStream;
import java.io.ObjectInputStream;
import java.util.List;

import ctd.net.rpc.transport.compression.CompressionUtils;


import io.netty.buffer.ByteBuf;
import io.netty.buffer.ByteBufInputStream;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.MessageToMessageDecoder;

public class JavaObjectDecoder extends MessageToMessageDecoder<ByteBuf> {

	@Override
	protected void decode(ChannelHandlerContext ctx, ByteBuf msg,List<Object> out) throws Exception {
		byte compression = msg.readByte();
		
		ByteBufInputStream bin = new ByteBufInputStream(msg);
		InputStream ins = CompressionUtils.buildInputStream(bin, compression);
		
		ObjectInputStream oin = new ObjectInputStream(ins);
		try{
			 out.add(oin.readObject());
		}
		finally{
			 oin.close();
		}
	}

}

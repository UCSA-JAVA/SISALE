package py.edu.ucsa.sisalews.config;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class ApplicationInfo {
	private String vendor;	
	private String version;
	private String artifact;
	private String build;
	
	public ApplicationInfo() {
	
	}
	
	public String getVendor() {
		return vendor;
	}
	public void setVendor(String vendor) {
		this.vendor = vendor;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getArtifact() {
		return artifact;
	}
	public void setArtifact(String artifact) {
		this.artifact = artifact;
	}
	public String getBuild() {
		return build;
	}
	public void setBuild(String build) {
		this.build = build;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ApplicationInfo [vendor=");
		builder.append(vendor);
		builder.append(", version=");
		builder.append(version);
		builder.append(", artifact=");
		builder.append(artifact);
		builder.append(", build=");
		builder.append(build);
		builder.append("]");
		return builder.toString();
	}
	
}
